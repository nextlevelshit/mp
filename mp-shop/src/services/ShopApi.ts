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

	async createOrder(): Promise<string> {
		const response = await fetch(`${this.baseUrl}/v1/order/`, {
			method: "POST",
		});
		return await response.text();
	}

	async getOrder(uuid: string): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}`);
		return this.handleResponse<any>(response);
	}

	async getOrCreateOrder(uuid?: string): Promise<any> {
		if (uuid) {
			try {
				// If UUID is provided, attempt to get the existing cart
				return await this.getOrder(uuid);
			} catch (error) {
				// If the cart doesn't exist, create a new one and then get it
				const newCartUuid = await this.createOrder();
				return await this.getOrder(newCartUuid);
			}
		} else {
			// If no UUID is provided, create a new cart and then get it
			const newCartUuid = await this.createOrder();
			return await this.getOrder(newCartUuid);
		}
	}


	async updateOrder(uuid: string, data: any): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}`, {
			method: "PUT",
			headers: {
				"content-type": "application/json"
			},
			body: JSON.stringify(data),
		});
		return this.handleResponse<any>(response);
	}

	async addProductToCart(uuid: string, productId: any, count = 1): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/add-product/${productId}?count=${count}`, {
			method: "PUT"
		});
		return this.handleResponse<any>(response);
	}

	async removeProductFromCart(uuid: string, productId: any, count = 1): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/remove-product/${productId}?count=${count}`, {
			method: "PUT"
		});
		return this.handleResponse<any>(response);
	}

	async checkoutOrder(uuid: string): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/checkout`, {
			method: "POST",
		});
		return this.handleResponse<any>(response);
	}

	async handleRedirect(uuid: string, method: string, data: any): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/redirect`, {
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
