import { factories } from "@strapi/strapi";
import { ID } from "@strapi/database/dist/types";
import { vatIncludedDecimal, vatDecimal } from "../../../../config/constants";
import { calculateTotalProductPrice } from "../../product/services/product";
import { sanitize } from "@strapi/utils";
import { CartProduct } from "../../../../types";

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

	generateInvoice: async (uuid: string) => {
		// Implement the logic to generate an invoice for an order
		const oderUnsafe = await strapi.service("api::order.order").findOneByUuid(uuid);
		return await sanitize.contentAPI.output(oderUnsafe, strapi.getModel("api::order.order"));
	},

	generateDeliveryNote: async (uuid: string) => {
		// Implement the logic to generate a delivery note for an order
		const oderUnsafe = await strapi.service("api::order.order").findOneByUuid(uuid);
		return await sanitize.contentAPI.output(oderUnsafe, strapi.getModel("api::order.order"));
	},

	sendInvoice: async (uuid: string) => {
		// Implement the logic to send an invoice for an order
		const oderUnsafe = await strapi.service("api::order.order").findOneByUuid(uuid);
		return await sanitize.contentAPI.output(oderUnsafe, strapi.getModel("api::order.order"));
	},

	finalize: async (uuid: string) => {
		// Implement the logic to finalize an order
		const oderUnsafe = await strapi.service("api::order.order").findOneByUuid(uuid);
		return await sanitize.contentAPI.output(oderUnsafe, strapi.getModel("api::order.order"));
	}
}));

const orderDefaultParams = {
	populate: {
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
