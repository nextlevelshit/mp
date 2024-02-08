import {Client, Config, CheckoutAPI} from "@adyen/api-library";
import {adyenApiKey, adyenEnvironment, adyenMerchantAccount, adyenClientKey, adyenHmacKey} from "../config/constants";
import {AdyenEnvironment} from "../types";
import debug from "debug";
import {PaymentCompletionDetails} from "@adyen/api-library/lib/src/typings/checkout/paymentCompletionDetails";
import HmacValidator from "@adyen/api-library/lib/src/utils/hmacValidator";
import {NotificationItem} from "@adyen/api-library/lib/src/typings/notification/notificationItem";
import {OrderDto} from "../dto/OrderDto";
import {NotificationRequestItem} from "@adyen/api-library/lib/src/typings/notification/notificationRequestItem";
import EventCodeEnum = NotificationRequestItem.EventCodeEnum;
import {depotApi} from "./DepotApi";
import {Counter} from "prom-client";

const logger = debug("app:i:shop-api:adyen-api");
const verbose = debug("app:v:shop-api:adyen-api");

const successfulSessionCreationCounter = new Counter({
	name: "mp_shop_api_adyen_successful_session_creation_total",
	help: "Total number of successful Adyen session creations",
});

const failedSessionCreationCounter = new Counter({
	name: "mp_shop_api_adyen_failed_session_creation_total",
	help: "Total number of failed Adyen session creations",
});

class AdyenApi {
	private readonly checkout: CheckoutAPI;
	private readonly clientKey: string;
	private readonly hmacKey: string;

	constructor(apiKey: string, clientKey: string, hmacKey: string, environment: AdyenEnvironment) {
		const config = new Config();
		config.apiKey = apiKey;

		const client = new Client({ config });
		client.setEnvironment(environment);

		this.checkout = new CheckoutAPI(client);
		this.clientKey = clientKey;
		this.hmacKey = hmacKey;
	}

	async createSessionOrThrow(returnUrl: string, order: OrderDto) {
		const reference = order.uuid;

		if (!order.total) throw new Error("Cart is empty or has no total");

		const checkoutConfig = {
			amount: {currency: "EUR", value: Math.round(order.total * 100)},
			countryCode: "DE",
			merchantAccount: adyenMerchantAccount,
			reference,
			returnUrl,
		};

		try {
			const session = await this.checkout.PaymentsApi.sessions(checkoutConfig);
			successfulSessionCreationCounter.inc();
			return session;
		} catch (error) {
			failedSessionCreationCounter.inc();
			// Handle errors and potentially increment a counter for failed session creations
			verbose("Error creating Adyen session:", error);
			throw error;
		}
	}

	async handleShopperRedirect(redirect: any) {
		const details: PaymentCompletionDetails = {};

		verbose("Redirecting customer after checkout");
		verbose(redirect);

		if (redirect.redirectResult) {
			details.redirectResult = redirect.redirectResult;
		} else if (redirect.payload) {
			details.payload = redirect.payload;
		}

		const response = await this.checkout.PaymentsApi.paymentsDetails({ details });

		switch (response.resultCode) {
			case "Authorised":
				return "/result/success";
			case "Pending":
			case "Received":
				return "/result/pending";
			case "Refused":
				return "/result/failed";
			default:
				return "/result/error";
		}
	}

	async handleWebhook(reqBody: { notificationItems: NotificationItem[] }) {
		const validator = new HmacValidator();
		const notification = reqBody.notificationItems[0].NotificationRequestItem;

		if (!validator.validateHMAC(notification, this.hmacKey)) {
			verbose("Invalid HMAC signature: " + notification);
			return { statusCode: 401, message: 'Invalid HMAC signature' };
		}

		await this.consumeEvent(notification);

		return { statusCode: 200, message: '[accepted]' };
	}

	private async consumeEvent(notification: NotificationRequestItem) {
		const {merchantReference: uuid, eventCode} = notification;
		verbose("Recieved valid notification")
		verbose("Order UUID: " + uuid + " eventCode: " + eventCode);

		if (eventCode === EventCodeEnum.Authorisation) {
			await depotApi.orderFactory().update(uuid, {
				paymentAuthorised: true
			})
		}
		// Add item to DB, queue, or different thread
	}
}

export const adyenApi = new AdyenApi(adyenApiKey, adyenClientKey, adyenHmacKey, adyenEnvironment);
