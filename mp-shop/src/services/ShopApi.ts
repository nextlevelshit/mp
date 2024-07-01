import debug from "debug";
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
import { shopApiToken } from "@/config/constants";
import type {
	ProductPatternShared,
	ProductPagesShared,
	ProductRulingShared
} from "@/shared";

const logger = debug("app:i:shop-api");
const verbose = debug("app:v:shop-api");
const silly = debug("app:d:shop-api");

class ShopApi {
	readonly baseUrl: string;
	readonly token: string;

	constructor(options: ShopApiOptions) {
		this.baseUrl = options.baseUrl;
		this.token = options.token;
	}

	private async handleResponse<T>(response: Response): Promise<T> {
		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}
		return (await response.json()) as T;
	}

	private async makeRequest(url: string, options?: RequestInit): Promise<Response> {
		verbose(`Making request to ${url}`);
		silly({
			...options,
			headers: {
				...options?.headers,
				authorization: `Bearer ${this.token}`,
				"content-type": "application/json"
			}
		});
		return await fetch(url, {
			...options,
			headers: {
				...options?.headers,
				authorization: `Bearer ${this.token}`,
				"content-type": "application/json"
			}
		});
	}

	async createOrder() {
		const response = await this.makeRequest(`${this.baseUrl}/order/`, {
			method: "POST"
		});
		return this.handleResponse<Order>(response);
	}

	async getOrder(uuid: string): Promise<Order> {
		const response = await this.makeRequest(`${this.baseUrl}/order/${uuid}`);
		return this.handleResponse<Order>(response);
	}

	async getOrCreateOrder(uuid?: string | null): Promise<Order> {
		const createOrderAndReturn = async (): Promise<Order> => {
			const newCartUuid = await this.createOrder();
			return await this.getOrder(newCartUuid.uuid as string);
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

	async updateOrder(uuid: string, data: OrderUpdateBody) {
		const response = await this.makeRequest(`${this.baseUrl}/order/${uuid}`, {
			method: "PUT",
			headers: {
				"content-type": "application/json"
			},
			body: JSON.stringify({ data })
		});
		return this.handleResponse<Order>(response);
	}

	async finalizeOrder(uuid: string): Promise<Order> {
		const response = await this.makeRequest(
			`${this.baseUrl}/order/${uuid}/finalize`,
			{
				method: "PUT"
			}
		);
		return this.handleResponse<Order>(response);
	}

	async addProductToCart(uuid: string, productId: number, count = 1): Promise<Order> {
		const response = await this.makeRequest(
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
		const response = await this.makeRequest(
			`${this.baseUrl}/order/${uuid}/remove-product/${productId}?count=${count}`,
			{
				method: "PUT"
			}
		);
		return this.handleResponse<Order>(response);
	}

	async checkoutOrder(uuid: string): Promise<any> {
		const returnUrl = window.location.href;
		const response = await this.makeRequest(
			`${this.baseUrl}/order/${uuid}/checkout?returnUrl=${encodeURIComponent(
				returnUrl
			)}`,
			{
				method: "POST"
			}
		);
		return this.handleResponse<any>(response);
	}

	async getProducts(coverId?: number) {
		const response = await this.makeRequest(
			`${this.baseUrl}/product?cover=${coverId || ""}`
		);
		return this.handleResponse<ShopResponse<Product>>(response);
	}

	async getProductById(id: string) {
		logger(`Requestion product from ${this.baseUrl}/product/${id}`);
		const response = await this.makeRequest(`${this.baseUrl}/product/${id}`);
		return this.handleResponse<Product>(response);
	}

	async getProductVariantsByProductId(id: string): Promise<ProductVariantResponse> {
		logger(`Requestion product variants from ${this.baseUrl}/product/${id}/variants`);
		const response = await this.makeRequest(`${this.baseUrl}/product/${id}/variants`);
		return this.handleResponse<ProductVariantResponse>(response);
	}

	async getPatternVariantsByProductId(id: string): Promise<PatternVariantsResponse> {
		logger(
			`Requestion pattern variants from ${this.baseUrl}/product/${id}/variants/pattern`
		);
		const response = await this.makeRequest(
			`${this.baseUrl}/product/${id}/variants/pattern`
		);
		return this.handleResponse<PatternVariantsResponse>(response);
	}

	async getProductRulings() {
		const response = await this.makeRequest(`${this.baseUrl}/product-ruling`);
		return this.handleResponse<ShopResponse<ProductRulingShared>>(response);
	}

	async getPaymentMethods() {
		const response = await this.makeRequest(`${this.baseUrl}/payments`);
		return this.handleResponse<ShopResponse<PaymentMethod>>(response);
	}

	async getDeliveryMethods() {
		const response = await this.makeRequest(`${this.baseUrl}/deliveries`);
		return this.handleResponse<ShopResponse<DeliveryMethod>>(response);
	}

	async getProductPatterns() {
		const response = await this.makeRequest(`${this.baseUrl}/product-patterns`);
		return this.handleResponse<ShopResponse<ProductPatternShared>>(response);
	}

	async getProductPages() {
		const response = await this.makeRequest(`${this.baseUrl}/product-pages`);
		return this.handleResponse<ShopResponse<ProductPagesShared>>(response);
	}

	async getProductCovers() {
		const response = await this.makeRequest(`${this.baseUrl}/product-covers`);
		return this.handleResponse<ShopResponse<ProductCover>>(response);
	}

	async getLegal(): Promise<Legal> {
		const response = await this.makeRequest(`${this.baseUrl}/legal`);
		return this.handleResponse<Legal>(response);
	}

	async getContent(): Promise<Content> {
		const response = await this.makeRequest(`${this.baseUrl}/content`);
		return this.handleResponse<Content>(response);
	}
}

interface ShopApiOptions {
	baseUrl: string;
	token: string;
}

interface ShopResponse<T> {
	data: T[];
	meta: {
		pagination: {
			page: number;
			pageCount: number;
			pageSize: number;
			total: number;
		};
	};
}

export const shopApi = new ShopApi({
	baseUrl: "/api",
	token: shopApiToken
});
