import { postamtPort } from "../config/constants";
import debug from "debug";
import {Counter} from "prom-client";

const logger = debug("mp:i:shop-api:postamt-api");
const verbose = debug("mp:v:shop-api:postamt-api");

const successfulTextMessageCounter = new Counter({
    name: "mp_shop_api_postamt_successful_text_message_sent_total",
    help: "Total number of successful text messages sent",
});

const failedTextMessageCounter = new Counter({
    name: "mp_shop_api_postamt_failed_text_message_sent_total",
    help: "Total number of failed text messages sent",
});

const successfulPdfCounter = new Counter({
    name: "mp_shop_api_postamt_successful_pdf_sent_total",
    help: "Total number of successful PDFs sent",
});

const failedPdfCounter = new Counter({
    name: "mp_shop_api_postamt_failed_pdf_sent_total",
    help: "Total number of failed PDFs sent",
});

class PostamtApi {
    baseUrl: string;
    headers: Headers;

    constructor(options: PostamtApiOptions) {
        this.baseUrl = options.baseUrl;
        this.headers = options.defaultHeaders ?? {};
    }

    async sendTextMessage(body: MessageBody): Promise<void> {
        try {
            const result = await this.postRequest("/send/message", body);
            successfulTextMessageCounter.inc();
            return result;
        } catch (error) {
            failedTextMessageCounter.inc();
            // Handle errors
            verbose("Error sending text message:", error);
            throw error;
        }
    }

    async sendPdf(body: PdfMessageBody): Promise<void> {
        try {
            const result = await this.postPdfRequest("/send/pdf", body);
            successfulPdfCounter.inc();
            return result;
        } catch (error) {
            failedPdfCounter.inc();
            // Handle errors
            verbose("Error sending PDF:", error);
            throw error;
        }
    }

    private async postRequest(endpoint: string, body: Record<string, any>): Promise<void> {
        const response = await fetch(`${this.baseUrl}${endpoint}`, {
            method: "POST",
            headers: {
                ...this.headers,
                "content-type": "application/json"
            },
            body: JSON.stringify(body),
        });

        if (!response.ok) {
            throw new Error(`Failed to send text message: ${response.statusText}`);
        }
    }

    private async postPdfRequest(endpoint: string, body: PdfMessageBody): Promise<void> {
        const formData = new FormData();
        formData.append("subject", body.subject);
        formData.append("message", body.message);
        formData.append("to_email", body.to_email);
        formData.append("pdf_blob", body.pdf_blob);

        const response = await fetch(`${this.baseUrl}${endpoint}`, {
            method: "POST",
            headers: {
                ...this.headers,
            },
            body: formData,
        });

        if (!response.ok) {
            throw new Error(`Failed to send PDF: ${response.statusText}`);
        }
    }
}

interface PostamtApiOptions {
    baseUrl: string;
    defaultHeaders?: Headers;
}

interface MessageBody {
    subject: string;
    message: string;
    to_email: string;
}

interface PdfMessageBody {
    subject: string;
    message: string;
    to_email: string;
    pdf_blob: Blob;
}

type Headers = Record<string, string>;

export const postamtApi = new PostamtApi({
    baseUrl: `http://mp-postamt:${postamtPort}/v1`
});
