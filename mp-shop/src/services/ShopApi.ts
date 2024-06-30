import type {
	Order,
	OrderUpdateBody,
	Product,
	ProductVariantResponse,
	PatternVariantsResponse,
	ProductCover,
	Legal,
	Content,
	PaymentMethod,
	DeliveryMethod
} from "@/types";
import debug from "debug";
import { shopApiToken } from "@/config/constants";

const logger = debug("app:i:shop-api");
const verbose = debug("app:v:shop-api");

class ShopApi {
	baseUrl: string;

	constructor(options: ShopApiOptions) {
		this.baseUrl = options.baseUrl;
	}

	private async handleResponse<T>(response: Response): Promise<T> {
		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}
		return (await response.json()) as T;
	}

	private makeRequest(url: string, options?: RequestInit): Promise<Response> {
		verbose(`Making request to ${url}`);
		return fetch(url, {
			...options,
			headers: {
				...options?.headers,
				authorization: `Bearer ${shopApiToken}`,
				"content-type": "application/json"
			}
		});
	}

	async createOrder(): Promise<string> {
		const response = this.makeRequest(`${this.baseUrl}/order/`, {
			method: "POST"
		});
		return await response.text();
	}

	async getOrder(uuid: string): Promise<Order> {
		const response = this.makeRequest(`${this.baseUrl}/order/${uuid}`);
		return this.handleResponse<Order>(response);
	}

	async getOrCreateOrder(uuid?: string | null): Promise<Order> {
		const createOrderAndReturn = async (): Promise<Order> => {
			const newCartUuid = await this.createOrder();
			return await this.getOrder(newCartUuid);
		};
		if (uuid) {
			// If UUID is provided, attempt to get the existing cart
			const order = await this.getOrder(uuid);

			if (!order || order.paymentAuthorised) {
				return await createOrderAndReturn();
			} else {
				return order;
			}
		} else {
			// If no UUID is provided, create a new cart and then get it
			return await createOrderAndReturn();
		}
	}

	async updateOrder(uuid: string, data: OrderUpdateBody): Promise<Order> {
		const response = this.makeRequest(`${this.baseUrl}/order/${uuid}`, {
			method: "PUT",
			headers: {
				"content-type": "application/json"
			},
			body: JSON.stringify(data)
		});
		return this.handleResponse<Order>(response);
	}

	async finalizeOrder(uuid: string): Promise<Order> {
		const response = this.makeRequest(`${this.baseUrl}/order/${uuid}/finalize`, {
			method: "PUT"
		});
		return this.handleResponse<Order>(response);
	}

	async addProductToCart(uuid: string, productId: number, count = 1): Promise<Order> {
		const response = this.makeRequest(
			`${this.baseUrl}/order/${uuid}/add-product/${productId}?count=${count}`,
			{
				method: "PUT"
			}
		);
		return this.handleResponse<Order>(response);
	}

	async removeProductFromCart(
		uuid: string,
		productId: number,
		count = 1
	): Promise<Order> {
		const response = this.makeRequest(
			`${this.baseUrl}/order/${uuid}/remove-product/${productId}?count=${count}`,
			{
				method: "PUT"
			}
		);
		return this.handleResponse<Order>(response);
	}

	async checkoutOrder(uuid: string): Promise<any> {
		const returnUrl = window.location.href;
		const response = this.makeRequest(
			`${this.baseUrl}/order/${uuid}/checkout?returnUrl=${encodeURIComponent(
				returnUrl
			)}`,
			{
				method: "POST"
			}
		);
		return this.handleResponse<any>(response);
	}

	async getProducts(coverId?: number): Promise<Product[]> {
		const response = this.makeRequest(
			`${this.baseUrl}/product?cover=${coverId || ""}`
		);
		return this.handleResponse<Product[]>(response);
	}

	async getProductById(id: string): Promise<Product> {
		logger(`Requestion product from ${this.baseUrl}/product/${id}`);
		const response = this.makeRequest(`${this.baseUrl}/product/${id}`);
		return this.handleResponse<Product>(response);
	}

	async getProductVariantsByProductId(id: string): Promise<ProductVariantResponse> {
		logger(`Requestion product variants from ${this.baseUrl}/product/${id}/variants`);
		const response = this.makeRequest(`${this.baseUrl}/product/${id}/variants`);
		return this.handleResponse<ProductVariantResponse>(response);
	}

	async getPatternVariantsByProductId(id: string): Promise<PatternVariantsResponse> {
		logger(
			`Requestion pattern variants from ${this.baseUrl}/product/${id}/variants/pattern`
		);
		const response = this.makeRequest(
			`${this.baseUrl}/product/${id}/variants/pattern`
		);
		return this.handleResponse<PatternVariantsResponse>(response);
	}

	async getProductRulings(): Promise<any> {
		const response = this.makeRequest(`${this.baseUrl}/product-ruling`);
		return this.handleResponse<any>(response);
	}

	async getPaymentMethods(): Promise<PaymentMethod[]> {
		const response = this.makeRequest(`${this.baseUrl}/payments`);
		return this.handleResponse<PaymentMethod[]>(response);
	}

	async getDeliveryMethods(): Promise<DeliveryMethod[]> {
		const response = this.makeRequest(`${this.baseUrl}/deliveries`);
		return this.handleResponse<DeliveryMethod[]>(response);
	}

	async getProductPatterns(): Promise<any> {
		const response = this.makeRequest(`${this.baseUrl}/product-patterns`);
		return this.handleResponse<any>(response);
	}

	async getProductPages(): Promise<any> {
		const response = this.makeRequest(`${this.baseUrl}/product-pages`);
		return this.handleResponse<any>(response);
	}

	async getProductCovers(): Promise<ProductCover[]> {
		const response = this.makeRequest(`${this.baseUrl}/product-cover`);
		return this.handleResponse<ProductCover[]>(response);
	}

	async getLegal(): Promise<Legal> {
		const response = this.makeRequest(`${this.baseUrl}/legal`);
		return this.handleResponse<Legal>(response);
	}

	async getContent(): Promise<Content> {
		const response = this.makeRequest(`${this.baseUrl}/content`);
		return this.handleResponse<Content>(response);
	}
}

interface ShopApiOptions {
	baseUrl: string;
}

export const shopApi = new ShopApi({
	baseUrl: "/api"
});
