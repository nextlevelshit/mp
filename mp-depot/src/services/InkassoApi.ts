import type { Response } from "node-fetch";
import { inkassoAddress } from "../../config/constants";
import { PdfBody } from "../../types";

const logger = strapi.log.info;
const verbose = strapi.log.verbose;
const debug = strapi.log.verbose;

class InkassoApi {
	baseUrl: string;
	headers: Headers;

	constructor(options: InkassoApiOptions) {
		this.baseUrl = options.baseUrl;
		this.headers = options.defaultHeaders ?? {};
	}

	async generateInvoice(body: PdfBody) {
		try {
			return await this.postRequest("/v1/invoice", body);
		} catch (error) {
			throw error;
		}
	}

	async generateDeliveryNote(body: PdfBody) {
		try {
			return await this.postRequest("/v1/shipping", body);
		} catch (error) {
			throw error;
		}
	}

	private async postRequest(endpoint: string, body: Record<string, any>) {
		const response = (await strapi.fetch(`${this.baseUrl}${endpoint}`, {
			method: "POST",
			headers: this.headers,
			body: JSON.stringify(body)
		})) as Response;
		return await response.arrayBuffer();
	}
}

interface InkassoApiOptions {
	baseUrl: string;
	defaultHeaders?: Headers;
}

type Headers = Record<string, string>;

export const inkassoApi = new InkassoApi({
	baseUrl: inkassoAddress,
	defaultHeaders: {
		"content-type": "application/json"
	}
});
