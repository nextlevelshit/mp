import { factories } from "@strapi/strapi";
import { sanitize } from "@strapi/utils";
import { v4 as generateUuid } from "uuid";
import { vatDecimal } from "../../../../config/constants";
import { adyenApi } from "../../../services/AdyenApi";
import { PdfBody, Order, NotificationRequest } from "../../../../types";
import { calculateTotalProductPrice } from "../../product/services/product";
import FormData from "form-data";
import { inkassoApi } from "../../../services/InkassoApi";

/**
 * A set of functions called "actions" for `order`
 */
export default factories.createCoreController("api::order.order", ({ strapi }) => ({
	// Create a new order
	create: async (ctx) => {
		const body = { data: { uuid: generateUuid() } };
		strapi.log.verbose(JSON.stringify({ body }));
		const order = await strapi.service("api::order.order").create(body);
		return await sanitize.contentAPI.output(
			order,
			strapi.getModel("api::order.order")
		);
	},

	// Get an order by uuid
	findOne: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::order.order")
		);
		strapi.log.verbose(JSON.stringify({ uuid }));
		const orderUnsafe = (await strapi
			.service("api::order.order")
			.findOneByUuid(uuid)) as Order;
		return (await sanitize.contentAPI.output(
			orderUnsafe,
			strapi.getModel("api::order.order")
		)) as Order;
	},

	addProduct: async (ctx) => {
		const { uuid, productId } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::order.order")
		);
		const count = parseInt(ctx.query.count as string) || 1;
		const product = parseInt(productId as string);

		strapi.log.verbose(JSON.stringify({ uuid, product, count }));

		const order = (await strapi
			.service("api::order.order")
			.findOneByUuid(uuid)) as Order;

		if (!order) {
			return ctx.notFound("Order not found");
		}

		const updatedCart = order.cart || [];
		const existingProductIndex = updatedCart.findIndex(
			(item) => item.product.id === product
		);

		if (existingProductIndex !== -1) {
			updatedCart[existingProductIndex].count += count;
		} else {
			// @ts-ignore
			updatedCart.push({ count, product });
		}

		strapi.log.verbose(JSON.stringify({ updatedCart }));

		const orderUnsafe = await strapi.service("api::order.order").update(order.id, {
			data: { cart: updatedCart }
		});

		return await sanitize.contentAPI.output(
			orderUnsafe,
			strapi.getModel("api::order.order")
		);
	},

	removeProduct: async (ctx) => {
		const { uuid, productId } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::order.order")
		);
		const count = parseInt(ctx.query.count as string) || 1;
		const product = parseInt(productId as string);

		strapi.log.verbose(JSON.stringify({ uuid, product, count }));

		const order = (await strapi
			.service("api::order.order")
			.findOneByUuid(uuid)) as Order;

		if (!order) {
			return ctx.notFound("Order not found");
		}

		const updatedCart = order.cart || [];
		const existingProductIndex = updatedCart.findIndex(
			(item) => item.product.id === product
		);

		if (existingProductIndex !== -1) {
			const currentCount = updatedCart[existingProductIndex].count;
			if (currentCount <= count) {
				updatedCart.splice(existingProductIndex, 1);
			} else {
				updatedCart[existingProductIndex].count -= count;
			}
		} else {
			return ctx.badRequest("Product not found in the cart");
		}

		strapi.log.verbose(JSON.stringify({ updatedCart }));

		const orderUnsafe = await strapi.service("api::order.order").update(order.id, {
			data: { cart: updatedCart }
		});

		return await sanitize.contentAPI.output(
			orderUnsafe,
			strapi.getModel("api::order.order")
		);
	},

	checkout: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::order.order")
		);
		const { returnUrl } = await sanitize.contentAPI.query(
			ctx.query,
			strapi.getModel("api::order.order")
		);
		strapi.log.verbose(JSON.stringify({ uuid, returnUrl }));
		const orderUnsafe = (await strapi
			.service("api::order.order")
			.findOneByUuid(uuid)) as Order;
		const adyenSession = await adyenApi.createSessionOrThrow(
			returnUrl as string,
			orderUnsafe
		);
		return { session: adyenSession, clientKey: adyenApi.getClientKey() };
	},

	redirect: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::order.order")
		);
		strapi.log.verbose(JSON.stringify({ uuid }));
		return await strapi.service("api::order.order").redirect(uuid);
	},

	generateInvoice: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::order.order")
		);
		strapi.log.verbose(JSON.stringify({ uuid }));
		return await strapi.service("api::order.order").generateInvoice(uuid);
	},

	generateDeliveryNote: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::order.order")
		);
		strapi.log.info(`order-controller: generating delivery note for ${uuid}`);
		const orderUnsafe = (await strapi
			.service("api::order.order")
			.findOneByUuid(uuid)) as Order;

		if (!orderUnsafe.paymentAuthorised) {
			return ctx.locked("Payment not authorised, cannot generate delivery note");
		}

		const pdfBody = deliveryNotePdfBody(orderUnsafe);
		const deliveryNoteBlob = await inkassoApi.generateDeliveryNote(pdfBody);

		strapi.log.info("order-controller: generated delivery note pdf");
		// strapi.log.debug(JSON.stringify(await deliveryNoteBlob.text()));

		if (!deliveryNoteBlob) {
			return ctx.internalServerError("Could not generate delivery note");
		}
		//
		// return deliveryNoteBlob;

		const data = new FormData();
		data.append("files.deliveryNote", deliveryNoteBlob);
		// body.append("data", {
		//   fileInfo: {
		//     name: "Lieferschein Name",
		//     caption: "Lieferschein Caption",
		//     alternativeText: "Lieferschein Alternative Text",
		//   },
		// });
		data.append("data", "{}");
		data.append("ref", "api::order.order");
		data.append("refId", orderUnsafe.id);

		// ctx.send({ message: "success" });

		strapi.log.info("order-controller: uploading delivery note pdf");
		strapi.log.debug(JSON.stringify({ data }));

		await strapi.plugins.upload.services.upload.upload(data);

		const updatedOrderUnsafe = await strapi
			.service("api::order.order")
			.findOne(orderUnsafe.id);

		return await sanitize.contentAPI.output(
			updatedOrderUnsafe,
			strapi.getModel("api::order.order")
		);
	},

	sendInvoice: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::order.order")
		);
		strapi.log.info(`order-controller: sending invoice for ${uuid}`);
		strapi.log.verbose(JSON.stringify({ ctx }));
		return await strapi.service("api::order.order").sendInvoice();
	},

	finalize: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::order.order")
		);
		strapi.log.info(`order-api: finalizing order ${uuid}`);
		strapi.log.verbose(JSON.stringify({ ctx }));
		return await strapi.service("api::order.order").finalize();
	},

	webhook: async (ctx) => {
		try {
			return adyenApi.handleWebhook(ctx.request.body as NotificationRequest);
		} catch (error) {
			strapi.log.error(`adyen-api: ${JSON.stringify({ error })}`);
			ctx.internalServerError();
		}
	}
}));

const invoicePdfBody = (order: Order): PdfBody => {
	const { id, invoiceAddress, cart, Date, email, address, VAT, subtotal, total, uuid } =
		order;

	return {
		subject: "RECHNUNG",
		date: Date.toLocaleString(),
		to: {
			name: "",
			address: invoiceAddress ? invoiceAddress.split("\n") : []
		},
		nr: {
			customer: `${id}`,
			order: uuid,
			invoice: "123"
		},
		service:
			cart.map((cartProduct) => ({
				description: cartProduct.product.name,
				price: {
					per_unit: calculateTotalProductPrice(cartProduct.product) || 0,
					total:
						(calculateTotalProductPrice(cartProduct.product) || 0) *
						cartProduct.count
				},
				count: cartProduct.count,
				nr: `${cartProduct.id}`
			})) || [],
		currency: "\\euro",
		body: "Thank you for your purchase!",
		total,
		subtotal,
		VAT: {
			amount: VAT,
			rate: vatDecimal * 100
		}
	};
};

const deliveryNotePdfBody = (order: Order): PdfBody => {
	const { id, cart, Date, email, address, VAT, subtotal, total, uuid } = order;

	return {
		subject: "LIEFERSCHEIN",
		date: Date.toLocaleString(),
		to: {
			name: "",
			address: address ? address.split("\n") : []
		},
		nr: {
			customer: `${id}`,
			order: uuid,
			shipping: "123"
		},
		service:
			cart.map((cartProduct) => ({
				description: cartProduct.product.name,
				price: {
					per_unit: calculateTotalProductPrice(cartProduct.product) || 0,
					total:
						(calculateTotalProductPrice(cartProduct.product) || 0) *
						cartProduct.count
				},
				count: cartProduct.count,
				nr: `${cartProduct.id}`
			})) || [],
		currency: "\\euro",
		body: "Thank you for your purchase!",
		total,
		subtotal,
		VAT: {
			amount: VAT,
			rate: vatDecimal * 100
		}
	};
};
