import type {Order, OrderUpdateBody} from "@/types";

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

	/**
	 * @deprecated
	 */
    async generateInvoice(uuid: string): Promise<Order> {
        const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/generate-invoice`, {
            method: "PUT"
        });
        return this.handleResponse<Order>(response);
    }

	/**
	 * @deprecated
	 */
    async generateDeliveryNote(uuid: string): Promise<Order> {
        const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/generate-delivery-note`, {
            method: "PUT"
        });
        return this.handleResponse<Order>(response);
    }

	/**
	 * @deprecated
	 */
	async sendInvoice(uuid: string): Promise<Order> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/send-invoice`, {
			method: "PUT"
		});
		return this.handleResponse<Order>(response);
	}

	/**
	 * @deprecated
	 */
	async handleRedirect(uuid: string, method: string, data: any): Promise<any> {
		const response = await fetch(`${this.baseUrl}/v1/order/${uuid}/redirect`, {
			method,
			body: data,
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
