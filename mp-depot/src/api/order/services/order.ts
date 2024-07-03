import path from "path";
import fs from "fs";
import { factories } from "@strapi/strapi";
import { sanitize } from "@strapi/utils";
import { ID } from "@strapi/database/dist/types";
import { vatIncludedDecimal, vatDecimal } from "../../../../config/constants";
import { calculateTotalProductPrice } from "../../product/services/product";
import { CartProduct, Order, PdfBody } from "../../../../types";
import { inkassoApi } from "../../../services/InkassoApi";

/**
 * This service is responsible for handling the order logic.
 */
export default factories.createCoreService("api::order.order", ({ strapi }) => ({
	update: async (id: ID, params: Record<string, any>) => {
		strapi.log.info(`app:v:order-service: - Updating order ID${id}`, { ...params, ...orderDefaultParams });
		const orderUnsafe = await strapi.entityService.update("api::order.order", id, {
			...params,
			...orderDefaultParams
		});
		strapi.log.info("app:v:order-service: ✔ Updating order ID${id}", { orderUnsafe });
		const cartProducts = orderUnsafe.cart;
		const delivery = orderUnsafe.delivery;
		const payment = orderUnsafe.payment;

		let subtotal = -1;
		let total = -1;
		let VAT = -1;
		strapi.log.verbose(`app:v:order-service: `, { cartProducts });
		if (cartProducts) {
			const productsTotal = cartProducts.reduce((v, p) => v + (calculateTotalProductPrice(p.product) ?? 0) * p.count, 0);
			const deliveryPrice = delivery ? delivery.price : 0;
			const paymentPrice = payment ? payment.price : 0;

			total = Math.round((productsTotal + deliveryPrice + paymentPrice) * 100) / 100;
			// TODO: Double-check
			VAT = Math.round((total / vatIncludedDecimal) * vatDecimal * 100) / 100;
			subtotal = Math.round((total - VAT) * 100) / 100;
		}
		const order = await strapi.entityService.update("api::order.order", id, {
			data: {
				subtotal,
				total,
				VAT
			},
			...orderDefaultParams
		});
		const cart = order.cart.map((product) => {
			return {
				...product,
				product: {
					...product.product,
					totalProductPrice: calculateTotalProductPrice(product.product)
				}
			};
		});
		strapi.log.verbose(`app:v:order-service: `, { cart });

		return {
			...order,
			cart
		};
	},

	findOne: async (id: ID) => {
		const order = await strapi.entityService.findOne("api::order.order", id, orderDefaultParams);
		const cart = order.cart.map((product) => {
			return {
				...product,
				product: {
					...product.product,
					totalProductPrice: calculateTotalProductPrice(product.product)
				}
			};
		});
		return {
			...order,
			cart
		};
	},

	findOneByUuid: async (uuid: string) => {
		const params = {
			filters: {
				uuid: {
					$eq: uuid
				}
			},
			...orderDefaultParams
		};
		const { results } = await strapi.service("api::order.order").find(params);
		const order = results.pop();
		const cart = order.cart.map((product: CartProduct) => {
			return {
				...product,
				product: {
					...product.product,
					totalProductPrice: calculateTotalProductPrice(product.product)
				}
			};
		});
		return {
			...order,
			cart
		};
	},

	checkout: async (uuid: string, returnUrl: string) => {
		// Implement the logic for the checkout process
		const oderUnsafe = await strapi.service("api::order.order").findOneByUuid(uuid);
		return await sanitize.contentAPI.output(oderUnsafe, strapi.getModel("api::order.order"));
	},

	redirect: async (uuid: string) => {
		// Implement the logic for the redirect process
		const oderUnsafe = await strapi.service("api::order.order").findOneByUuid(uuid);
		return await sanitize.contentAPI.output(oderUnsafe, strapi.getModel("api::order.order"));
	},

	uploadPdf: async (orderUnsafe: Order, field: string, name = "Upload") => {
		strapi.log.verbose("app:v:order-service: – Generating delivery note pdf");
		const pdfBody = deliveryNotePdfBody(orderUnsafe);
		const deliveryNoteBlob = await inkassoApi.generateDeliveryNote(pdfBody);
		strapi.log.verbose("app:v:order-service: ✔ Generating delivery note pdf");

		// Save blob to a temp folder
		const tempFolder = path.join(__dirname, "temp");
		if (!fs.existsSync(tempFolder)) {
			fs.mkdirSync(tempFolder);
		}
		const deliveryNotePath = path.join(tempFolder, `${name}.pdf`);
		fs.writeFileSync(deliveryNotePath, Buffer.from(deliveryNoteBlob));

		const uploadData = {
			data: {
				ref: "api::order.order",
				refId: orderUnsafe.id,
				field
			},
			files: {
				path: deliveryNotePath,
				name: `${name} ${pdfBody.date} ${pdfBody.to.name || pdfBody.to.address[0]}`,
				type: "application/pdf",
				size: fs.statSync(deliveryNotePath).size
			}
		};

		strapi.log.verbose("app:v:order-service: - Uploading delivery note pdf");
		await strapi.plugins.upload.services.upload.upload(uploadData);
		strapi.log.verbose("app:v:order-service: ✔ Uploading delivery note pdf");

		return await strapi.service("api::order.order").findOne(orderUnsafe.id);
	},

	sendInvoice: async (uuid: string) => {
		// Implement the logic to send an invoice for an order
		const oderUnsafe = await strapi.service("api::order.order").findOneByUuid(uuid);
		return await sanitize.contentAPI.output(oderUnsafe, strapi.getModel("api::order.order"));
	}
}));

const orderDefaultParams = {
	populate: {
		invoice: true,
		deliveryNote: true,
		delivery: true,
		payment: true,
		customer: true,
		cart: {
			populate: {
				product: {
					populate: {
						pattern: true,
						cover: true,
						ruling: true,
						pages: true
					}
				}
			}
		}
	}
};

const invoicePdfBody = (order: Order): PdfBody => {
	const { id, invoiceAddress, cart, Date, VAT, subtotal, total, uuid } = order;

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
					total: (calculateTotalProductPrice(cartProduct.product) || 0) * cartProduct.count
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
	const { id, cart, Date, address, VAT, subtotal, total, uuid } = order;

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
					total: (calculateTotalProductPrice(cartProduct.product) || 0) * cartProduct.count
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
