import type {Order, OrderUpdateBody, Product, ProductVariantResponse, PatternVariantsResponse} from "@/types";
import debug from "debug";

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
		return await response.json() as T;
	}

	async createOrder(): Promise<string> {
		const response = await fetch(`${this.baseUrl}/v1/order/`, {
			method: "POST",
		});
		return await response.text();
	}

	async getOrder(uuid: string): Promise<Order> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}`);
		return this.handleResponse<Order>(response);
	}

	async getOrCreateOrder(uuid?: string | null): Promise<Order> {
		const createOrderAndReturn = async (): Promise<Order> => {
			const newCartUuid = await this.createOrder();
			return await this.getOrder(newCartUuid);
		}
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
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}`, {
			method: "PUT",
			headers: {
				"content-type": "application/json"
			},
			body: JSON.stringify(data),
		});
		return this.handleResponse<Order>(response);
	}

	async finalizeOrder(uuid: string): Promise<Order> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/finalize`, {
			method: "PUT"
		});
		return this.handleResponse<Order>(response);
	}

	async addProductToCart(uuid: string, productId: number, count = 1): Promise<Order> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/add-product/${productId}?count=${count}`, {
			method: "PUT"
		});
		return this.handleResponse<Order>(response);
	}

	async removeProductFromCart(uuid: string, productId: number, count = 1): Promise<Order> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/remove-product/${productId}?count=${count}`, {
			method: "PUT"
		});
		return this.handleResponse<Order>(response);
	}

	async checkoutOrder(uuid: string): Promise<any> {
		const returnUrl = window.location.href;
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/checkout?returnUrl=${encodeURIComponent(returnUrl)}`, {
			method: "POST",
		});
		return this.handleResponse<any>(response);
	}

	async getProducts(coverId?: number): Promise<Product[]> {
		const response = await fetch(`${this.baseUrl}/v1/product?cover=${coverId || ""}`);
		return this.handleResponse<Product[]>(response);
	}

	async getProductById(id: string): Promise<Product> {
		logger(`Requestion product from ${this.baseUrl}/v1/product/${id}`);
		const response = await fetch(`${this.baseUrl}/v1/product/${id}`);
		return this.handleResponse<Product>(response);
	}

	async getProductVariantsByProductId(id: string): Promise<ProductVariantResponse> {
		logger(`Requestion product variants from ${this.baseUrl}/v1/product/${id}/variants`);
		const response = await fetch(`${this.baseUrl}/v1/product/${id}/variants`);
		return this.handleResponse<ProductVariantResponse>(response);
	}

	async getPatternVariantsByProductId(id: string): Promise<PatternVariantsResponse> {
		logger(`Requestion pattern variants from ${this.baseUrl}/v1/product/${id}/variants/pattern`);
		const response = await fetch(`${this.baseUrl}/v1/product/${id}/variants/pattern`);
		return this.handleResponse<PatternVariantsResponse>(response);
	}

	async getProductRulings(): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/product-ruling`);
		return this.handleResponse<any>(response);
	}

	async getPaymentMethods(): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/payment-method`);
		return this.handleResponse<any>(response);
	}

	async getDeliveryMethods(): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/delivery-method`);
		return this.handleResponse<any>(response);
	}

	async getProductPatterns(): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/product-pattern`);
		return this.handleResponse<any>(response);
	}

	async getProductPages(): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/product-pages`);
		return this.handleResponse<any>(response);
	}

	async getProductCovers(): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/product-cover`);
		return this.handleResponse<any>(response);
	}

	async getLegal(): Promise<LegalResponse> {
		const response = await fetch(`${this.baseUrl}/v1/legal`);
		return this.handleResponse<LegalResponse>(response);
	}
}

interface ShopApiOptions {
	baseUrl: string;
}

interface LegalResponse {
	imprint?: string;
	contact?: string;
	privacyPolicy?: string;
	terms?: string;
}

export const shopApi = new ShopApi({
	baseUrl: "/api",
});
