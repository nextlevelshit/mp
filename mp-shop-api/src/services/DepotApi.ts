import {v4 as generateUuid} from "uuid";
import qs from "qs";
import {depotBearerToken, depotPort} from "../config/constants";
import {
	Order,
	Product,
	ProductRuling,
	PaymentMethod,
	DeliveryMethod,
	ProductPattern,
	ProductPages, ProductCover, OrderUpdate, OrderUpdatedTotalRequest
} from "../util/types";
import {ProductDto} from "../dto/ProductDto";
import {ProductRulingDto} from "../dto/ProductRulingDto";
import {DeliveryMethodDto} from "../dto/DeliveryMethodDto";
import {PaymentMethodDto} from "../dto/PaymentMethodDto";
import {ProductPatternDto} from "../dto/ProductPatternDto";
import {ProductPagesDto} from "../dto/ProductPagesDto";
import {ProductCoverDto} from "../dto/ProductCoverDto";
import debug from "debug";
import {OrderDto} from "../dto/OrderDto";
import {inkassoApi} from "./InkassoApi";
import {postamtApi} from "./PostamtApi";

const logger = debug("app:i:shop-api:depot-api");
const verbose = debug("app:v:shop-api:depot-api");

class DepotApi {
	readonly host: string;
	baseUrl: string;
	headers: Headers;

	constructor(options: DepotApiOptions) {
		this.host = options.host;
		this.baseUrl = options.baseUrl;
		this.headers = options.defaultHeaders ?? {};
	}

	private async fetchEntity<T>(
		endpoint: string,
		mapDto: (item: T) => any,
		filter?: any
	): Promise<any[]> {
		const query = filter ? qs.stringify(filter, {encode: false}) : "";

		verbose(`Querying ${endpoint} with "${query}"`);

		const response = await fetch(`${this.baseUrl}/${endpoint}?${query}&populate=deep,2`, {
			method: "GET",
			headers: this.headers,
		});

		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}

		const {data} = await response.json();
		return (data as T[]).map((item) => mapDto(item).dto);
	}

	orderFactory() {
		return {
			create: async () => {
				const uuid = generateUuid();

				verbose(`Creating cart with UUID ${uuid}`);

				const response = await fetch(`${this.baseUrl}/orders?populate=uuid`, {
					method: "POST",
					headers: this.headers,
					body: JSON.stringify({
						data: {
							uuid
						}
					})
				});

				const {data} = await response.json();

				return data as Order;
			},

			one: async (uuid: string) => {
				const response = await fetch(
					`${this.baseUrl}/orders?filters[uuid][$eq]=${uuid}&populate=deep,4`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				const {data} = await response.json();

				return data.pop() as Order;
			},

			update: async (uuid: string, orderUpdates: Partial<OrderUpdate>) => {
				const order = new OrderDto(await this.orderFactory().one(uuid));

				const responseWithoutTotal = await fetch(
					`${this.baseUrl}/orders/${order.id}?populate=deep,4`,
					{
						method: "PUT",
						headers: this.headers,
						body: JSON.stringify({data: orderUpdates})
					}
				);

				const orderUpdatedWithoutTotal = await responseWithoutTotal.json();

				if (orderUpdatedWithoutTotal.error) {
					throw new Error(JSON.stringify(orderUpdatedWithoutTotal.error));
				}

				const orderAfterUpdate = new OrderDto(orderUpdatedWithoutTotal.data).dto;

				const data : OrderUpdatedTotalRequest = {
					VAT: orderAfterUpdate.VAT,
					total: orderAfterUpdate.total,
					subtotal: orderAfterUpdate.subtotal
				}

				const responseWithTotal = await fetch(
					`${this.baseUrl}/orders/${order.id}?populate=deep,4`,
					{
						method: "PUT",
						headers: this.headers,
						body: JSON.stringify({data})
					}
				);

				const orderUpdatedWithTotal = await responseWithTotal.json();

				if (orderUpdatedWithTotal.error) {
					throw new Error(JSON.stringify(orderUpdatedWithTotal.error));
				}

				return orderUpdatedWithTotal.data as Order;
			},
			addProduct: async (uuid: string, productId: string, count: number = 1) => {
				const order = new OrderDto(await this.orderFactory().one(uuid));
				const product = await this.productFactory().one(productId);

				if (!order) throw new Error(`Could not find order with UUID ${uuid}`);
				if (!product) throw new Error(`Could not find product with ID ${productId}`);

				const currentCartProducts = order.cartProducts || [];
				const updatedCartProducts = currentCartProducts.map(cartProduct => {
					if (cartProduct.product.id === parseInt(productId)) {
						// Product is already in the cart, increment the count
						return {
							count: cartProduct.count + count,
							product: cartProduct.product.id,
						};
					}
					return {
						count: cartProduct.count,
						product: cartProduct.product.id
					};
				});

				// If product not found in currentCartProducts, add it to updatedCartProducts
				const isProductAlreadyInCart = currentCartProducts.find(cartProduct => cartProduct.product.id === parseInt(productId));
				if (!isProductAlreadyInCart) {
					updatedCartProducts.push({
						count,
						product: parseInt(productId),
					});
				}

				return this.orderFactory().update(uuid, {
					cart: updatedCartProducts
				});
			},
			removeProduct: async (uuid: string, productId: string, count: number = 1) => {
				const order = new OrderDto(await this.orderFactory().one(uuid));
				const product = await this.productFactory().one(productId);

				if (!order) throw new Error(`Could not find order with UUID ${uuid}`);
				if (!product) throw new Error(`Could not find product with ID ${productId}`);

				const currentCartProducts = order.cartProducts || [];

				const updatedCartProducts = currentCartProducts
					.map(cartProduct => {
						if (cartProduct.product.id === parseInt(productId)) {
							// Product is in the cart, decrement the count or remove if count is 1
							return {
								count: Math.max(0, cartProduct.count - count),
								product: cartProduct.product.id,
							};
						}
						return {
							count: cartProduct.count,
							product: cartProduct.product.id
						};
					})
					// Remove products with count 0
					.filter(cartProduct => cartProduct.count > 0);

				return this.orderFactory().update(uuid, {
					cart: updatedCartProducts
				});
			},
			generateInvoiceAndSaveToOrder: async (uuid: string) => {
				const orderResponse = await this.orderFactory().one(uuid);

				if (!orderResponse) throw new Error("Could not fetch order");

				const order = new OrderDto(orderResponse);

				if (!order.paymentAuthorised) throw new Error("Payment not authorised, cannot generate invoice");

				const invoiceBlob = await inkassoApi.generateInvoice(order.invoicePdfBody);

				if (!invoiceBlob) throw new Error(`Could not generate invoice, check invoice data: ${JSON.stringify(order.invoicePdfBody)}`);

				const body = new FormData();
				body.append("files.invoice", invoiceBlob, "Generated invoice by mp-inkasso");
				body.append("data", "{}");

				const updatedOrderResponse = await fetch(
					`${this.baseUrl}/orders/${order.id}?populate=deep,4`,
					{
						method: "PUT",
						headers: {
							authorization: this.headers.authorization
						},
						body
					}
				);

				if (!updatedOrderResponse.ok) {
					throw new Error(updatedOrderResponse.statusText);
				}

				const {data} = await updatedOrderResponse.json();

				return data as Order;
			},
			generateDeliveryNoteAndSaveToOrder: async (uuid: string) => {
				const orderResponse = await this.orderFactory().one(uuid);

				if (!orderResponse) throw new Error("Could not fetch order");

				const order = new OrderDto(orderResponse);

				if (!order.paymentAuthorised) throw new Error("Payment not authorised, cannot generate delivery note");

				const deliveryNoteBlob = await inkassoApi.generateDeliveryNote(order.deliveryNotePdfBody);

				if (!deliveryNoteBlob) throw new Error(`Could not generate delivery note, check invoice data: ${JSON.stringify(order.deliveryNotePdfBody)}`);

				const body = new FormData();
				body.append("files.deliveryNote", deliveryNoteBlob, "Generated delivery note by mp-inkasso");
				body.append("data", "{}");

				const updatedOrderResponse = await fetch(
					`${this.baseUrl}/orders/${order.id}?populate=deep,4`,
					{
						method: "PUT",
						headers: {
							authorization: this.headers.authorization
						},
						body
					}
				);

				if (!updatedOrderResponse.ok) {
					throw new Error(updatedOrderResponse.statusText);
				}

				const {data} = await updatedOrderResponse.json();

				return data as Order;
			},
			sendInvoiceAndUpdateOrder: async (uuid: string) => {
				const orderResponse = await this.orderFactory().one(uuid);

				if (!orderResponse) throw new Error("Could not fetch order");

				const order = new OrderDto(orderResponse);

				if (!order.paymentAuthorised)
					throw new Error("Payment not authorised, cannot send invoice");

				if (!order.email)
					throw new Error("Email address not found, cannot send invoice");

				if (!order.invoice) {
					throw new Error(
						`Could not find invoice data in order: ${JSON.stringify(order)}`
					);
				}

				const invoiceUrl = `${this.host}${order.invoice.attributes.url}`;

				const invoiceBlob = await fetch(invoiceUrl).then((res) => res.blob());

				await postamtApi.sendPdf({
					subject: "Invoice",
					message: "Invoice for your order",
					to_email: order.email,
					pdf_blob: invoiceBlob,
				});

				return this.orderFactory().update(uuid, {
					emailSent: true
				});
			}
		};
	}

	productFactory() {
		return {
			one: async (id: string) => {
				const response = await fetch(
					`${this.baseUrl}/products/${id}?populate=deep,2`,
					{
						method: "GET",
						headers: this.headers
					}
				);

				if (!response.ok) {
					throw new Error(`Could not find product with ID ${id}`);
				}

				const {data} = await response.json();

				return new ProductDto(data).dto;
			},
			all: async (filter?: any) => {
				return this.fetchEntity<Product>(
					"products",
					(product) => new ProductDto(product),
					filter
				);
			},
		}
	}

	async productRuling(filter?: any) {
		return this.fetchEntity<ProductRuling>(
			"product-rulings",
			(productRuling) => new ProductRulingDto(productRuling),
			filter
		);
	}

	async productPattern() {
		return this.fetchEntity<ProductPattern>(
			"product-patterns",
			(pattern) => new ProductPatternDto(pattern)
		);
	}

	async productPages() {
		return this.fetchEntity<ProductPages>(
			"product-pages",
			(pages) => new ProductPagesDto(pages)
		);
	}

	async productCover() {
		return this.fetchEntity<ProductCover>(
			"product-covers",
			(cover) => new ProductCoverDto(cover)
		);
	}

	async deliveryMethod() {
		return this.fetchEntity<DeliveryMethod>(
			"deliveries",
			(deliveryMethod) => new DeliveryMethodDto(deliveryMethod)
		);
	}

	async paymentMethod() {
		return this.fetchEntity<PaymentMethod>(
			"payments",
			(paymentMethod) => new PaymentMethodDto(paymentMethod)
		);
	}
}

interface DepotApiOptions {
	host: string;
	baseUrl: string;
	defaultHeaders?: Headers;
}

type Headers = Record<string, string>;

export const depotApi = new DepotApi({
	host: `http://mp-depot:${depotPort}`,
	baseUrl: `http://mp-depot:${depotPort}/api`,
	defaultHeaders: {
		authorization: `Bearer ${depotBearerToken}`,
		"content-type": "application/json"
	}
});
