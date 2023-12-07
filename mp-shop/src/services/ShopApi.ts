class ShopApi {
	baseUrl: string;

	constructor(options: ShopApiOptions) {
		this.baseUrl = options.baseUrl;
	}

	private async handleResponse<T>(response: Response): Promise<T> {
		if (!response.ok) {
			throw new Error(`Request failed with status ${response.status}`);
		}
		return await response.json();
	}

	async createCart(): Promise<string> {
		const response = await fetch(`${this.baseUrl}/v1/cart/`, {
			method: "POST",
		});
		return await response.text();
	}

	async getCart(uuid: string): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/cart/${uuid}`);
		return this.handleResponse<any>(response);
	}

	async getOrCreateCart(uuid?: string): Promise<any> {
		if (uuid) {
			try {
				// If UUID is provided, attempt to get the existing cart
				return await this.getCart(uuid);
			} catch (error) {
				// If the cart doesn't exist, create a new one and then get it
				const newCartUuid = await this.createCart();
				return await this.getCart(newCartUuid);
			}
		} else {
			// If no UUID is provided, create a new cart and then get it
			const newCartUuid = await this.createCart();
			return await this.getCart(newCartUuid);
		}
	}


	async updateCart(uuid: string, data: any): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/cart/${uuid}`, {
			method: "PUT",
			body: JSON.stringify(data),
		});
		return this.handleResponse<any>(response);
	}

	async checkoutCart(uuid: string): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/cart/${uuid}/checkout`, {
			method: "POST",
		});
		return this.handleResponse<any>(response);
	}

	async handleRedirect(uuid: string, method: string, data: any): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/cart/${uuid}/redirect`, {
			method,
			body: JSON.stringify(data),
		});
		return this.handleResponse<any>(response);
	}

	async getProducts(): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/product`);
		return this.handleResponse<any>(response);
	}

	async getProductById(id: string): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/product/${id}`);
		return this.handleResponse<any>(response);
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
}

interface ShopApiOptions {
	baseUrl: string;
}

export const shopApi = new ShopApi({
	baseUrl: "/api",
});
