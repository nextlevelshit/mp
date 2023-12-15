import {inkassoPort} from "../config/constants";
import {PdfBody} from "../util/types";

class InkassoApi {
    baseUrl: string;
    headers: Headers;

    constructor(options: InkassoApiOptions) {
        this.baseUrl = options.baseUrl;
        this.headers = options.defaultHeaders ?? {};
    }

    async generateInvoice(body: PdfBody): Promise<Blob> {
        return await this.postRequest("/invoice", body);
    }

    async generateDeliveryNote(body: PdfBody): Promise<Blob> {
        return await this.postRequest("/shipping", body);
    }

    private async postRequest(endpoint: string, body: Record<string, any>): Promise<Blob> {
        const response = await fetch(`${this.baseUrl}${endpoint}`, {
            method: "POST",
            headers: this.headers,
            body: JSON.stringify(body),
        });
        return await response.blob();
    }
}

interface InkassoApiOptions {
    baseUrl: string;
    defaultHeaders?: Headers;
}

type Headers = Record<string, string>;

export const inkassoApi = new InkassoApi({
    baseUrl: `http://mp-inkasso:${inkassoPort}/v1`,
    defaultHeaders: {
        "content-type": "application/json",
    },
});
