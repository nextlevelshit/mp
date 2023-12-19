import {inkassoPort} from "../config/constants";
import {PdfBody} from "../util/types";
import {Counter} from "prom-client";
import debug from "debug";

const logger = debug("mp:i:shop-api:inkasso-api");
const verbose = debug("mp:v:shop-api:inkasso-api");


const successfulInvoiceCounter = new Counter({
    name: "mp_shop_api_inkasso_successful_invoice_generation_total",
    help: "Total number of successful invoice generations",
});

const failedInvoiceCounter = new Counter({
    name: "mp_shop_api_inkasso_failed_invoice_generation_total",
    help: "Total number of failed invoice generations",
});

const successfulDeliveryNoteCounter = new Counter({
    name: "mp_shop_api_inkasso_successful_delivery_note_generation_total",
    help: "Total number of successful delivery note generations",
});

const failedDeliveryNoteCounter = new Counter({
    name: "mp_shop_api_inkasso_failed_delivery_note_generation_total",
    help: "Total number of failed delivery note generations",
});

class InkassoApi {
    baseUrl: string;
    headers: Headers;

    constructor(options: InkassoApiOptions) {
        this.baseUrl = options.baseUrl;
        this.headers = options.defaultHeaders ?? {};
    }

    async generateInvoice(body: PdfBody): Promise<Blob> {
        try {
            const result = await this.postRequest("/invoice", body);
            successfulInvoiceCounter.inc();
            return result;
        } catch (error) {
            failedInvoiceCounter.inc();
            // Handle errors
            verbose("Error generating invoice:", error);
            throw error;
        }
    }

    async generateDeliveryNote(body: PdfBody): Promise<Blob> {
        try {
            const result = await this.postRequest("/shipping", body);
            successfulDeliveryNoteCounter.inc();
            return result;
        } catch (error) {
            failedDeliveryNoteCounter.inc();
            // Handle errors
            verbose("Error generating delivery note:", error);
            throw error;
        }
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
