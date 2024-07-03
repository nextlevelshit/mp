import { factories } from "@strapi/strapi";
import { sanitize } from "@strapi/utils";
import { v4 as generateUuid } from "uuid";
import { adyenApi } from "../../../services/AdyenApi";
import { Order, NotificationRequest } from "../../../../types";

/**
 * A set of functions called "actions" for `order`
 */
export default factories.createCoreController("api::order.order", ({ strapi }) => ({
	create: async (ctx) => {
		const body = { data: { uuid: generateUuid() } };
		strapi.log.verbose("Creating new order", { body });
		const order = await strapi.service("api::order.order").create(body);
		return await sanitize.contentAPI.output(order, strapi.getModel("api::order.order"));
	},

	update: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		strapi.log.verbose("app:v:order-controller: Updating", { uuid });
		const order = (await strapi.service("api::order.order").findOneByUuid(uuid)) as Order;
		const body = await sanitize.contentAPI.input(ctx.request.body, strapi.getModel("api::order.order"));
		strapi.log.verbose("app:v:order-controller: Sanitized body:", { body });
		return await strapi.service("api::order.order").update(order.id, body);
	},

	// Get an order by uuid
	findOne: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		strapi.log.verbose(JSON.stringify({ uuid }));
		const orderUnsafe = (await strapi.service("api::order.order").findOneByUuid(uuid)) as Order;
		return await sanitize.contentAPI.output(orderUnsafe, strapi.getModel("api::order.order"));
	},

	addProduct: async (ctx) => {
		const { uuid, productId } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		const count = parseInt(ctx.query.count as string) || 1;
		const product = parseInt(productId as string);

		strapi.log.verbose("app:v:order-controller: Removing product from cart", { uuid, product, count });

		const order = (await strapi.service("api::order.order").findOneByUuid(uuid)) as Order;

		if (!order) {
			return ctx.notFound("Order not found");
		}

		const updatedCart = order.cart || [];
		const existingProductIndex = updatedCart.findIndex((item) => item.product.id === product);

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

		return await sanitize.contentAPI.output(orderUnsafe, strapi.getModel("api::order.order"));
	},

	removeProduct: async (ctx) => {
		const { uuid, productId } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		const count = parseInt(ctx.query.count as string) || 1;
		const product = parseInt(productId as string);

		strapi.log.verbose("app:v:order-controller: Removing product from cart", { uuid, product, count });

		const order = (await strapi.service("api::order.order").findOneByUuid(uuid)) as Order;

		if (!order) {
			return ctx.notFound("Order not found");
		}

		const updatedCart = order.cart || [];
		const existingProductIndex = updatedCart.findIndex((item) => item.product.id === product);

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

		return await sanitize.contentAPI.output(orderUnsafe, strapi.getModel("api::order.order"));
	},

	checkout: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		const { returnUrl } = await sanitize.contentAPI.query(ctx.query, strapi.getModel("api::order.order"));
		strapi.log.verbose("app:v:order-controller: Checking out order", { uuid, returnUrl });
		const orderUnsafe = (await strapi.service("api::order.order").findOneByUuid(uuid)) as Order;
		const adyenSession = await adyenApi.createSessionOrThrow(returnUrl as string, orderUnsafe);
		return { session: adyenSession, clientKey: adyenApi.getClientKey() };
	},

	redirect: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		strapi.log.verbose("app:v:order-controller: Redirecting", { uuid });
		return await strapi.service("api::order.order").redirect(uuid);
	},

	generateInvoice: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		strapi.log.info(`app:i:order-controller: Started invoice generation`);
		const orderUnsafe = (await strapi.service("api::order.order").findOneByUuid(uuid)) as Order;

		if (!orderUnsafe.paymentAuthorised) {
			return ctx.locked("Payment not authorised, cannot generate invoice");
		}

		try {
			const updatedOrderUnsafe = await strapi.service("api::order.order").uploadPdf(orderUnsafe, "invoice", "Rechnung");
			return await sanitize.contentAPI.output(updatedOrderUnsafe, strapi.getModel("api::order.order"));
		} catch (error) {
			strapi.log.error("app:e:order-controller: Error uploading delivery note pdf", { error });
			return ctx.internalServerError("Could not upload delivery note");
		}
	},

	generateDeliveryNote: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		strapi.log.info(`app:i:order-controller: Started delivery note generation`);
		const orderUnsafe = (await strapi.service("api::order.order").findOneByUuid(uuid)) as Order;

		if (!orderUnsafe.paymentAuthorised) {
			return ctx.locked("Payment not authorised, cannot generate delivery note");
		}

		try {
			const updatedOrderUnsafe = await strapi.service("api::order.order").uploadPdf(orderUnsafe, "deliveryNote", "Lieferschein");
			return await sanitize.contentAPI.output(updatedOrderUnsafe, strapi.getModel("api::order.order"));
		} catch (error) {
			strapi.log.error("app:e:order-controller: Error uploading delivery note pdf", { error });
			return ctx.internalServerError("Could not upload delivery note");
		}
	},

	sendInvoice: async (ctx) => {
		const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		strapi.log.info("app:i:order-controller: Sending invoice for", { uuid });
		strapi.log.verbose("app:v:order-controller:", { ctx });
		return await strapi.service("api::order.order").sendInvoice();
	},

	finalize: async (ctx, next) => {
		const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
		strapi.log.info(`app:i:order-controller: - Finalizing order ${uuid}`);

		await Promise.all([
			strapi.controller("api::order.order").generateDeliveryNote(ctx, next),
			strapi.controller("api::order.order").generateInvoice(ctx, next)
		]);

		strapi.log.info(`app:i:order-controller: ✔ Finalizing order ${uuid}`);

		const orderUnsafe = await strapi.service("api::order.order").findOneByUuid(uuid);
		return await sanitize.contentAPI.output(orderUnsafe, strapi.getModel("api::order.order"));
	},

	webhook: async (ctx) => {
		try {
			return adyenApi.handleWebhook(ctx.request.body as NotificationRequest);
		} catch (error) {
			strapi.log.error(`adyen-api: ${JSON.stringify({ error })}`);
			return ctx.internalServerError();
		}
	}
}));
