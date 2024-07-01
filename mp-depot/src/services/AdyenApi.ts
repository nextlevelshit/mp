import { Client, Config, CheckoutAPI } from "@adyen/api-library";
import { adyenApiKey, adyenEnvironment, adyenMerchantAccount, adyenClientKey, adyenHmacKey } from "../../config/constants";
import { PaymentCompletionDetails } from "@adyen/api-library/lib/src/typings/checkout/paymentCompletionDetails";
import HmacValidator from "@adyen/api-library/lib/src/utils/hmacValidator";
import { NotificationRequestItem } from "@adyen/api-library/lib/src/typings/notification/notificationRequestItem";
import EventCodeEnum = NotificationRequestItem.EventCodeEnum;
import { AdyenEnvironment, Order, NotificationRequest } from "../../types";
import { CreateCheckoutSessionRequest } from "@adyen/api-library/lib/src/typings/checkout/models";

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

	async createSessionOrThrow(returnUrl: string, order: Order) {
		const reference = order.uuid;

		if (!order.total) throw new Error("Cart is empty or has no total");

		const checkoutConfig = {
			amount: { currency: "EUR", value: Math.round(order.total * 100) },
			countryCode: "DE",
			merchantAccount: adyenMerchantAccount,
			reference,
			returnUrl,
			shopperLocale: "de-DE"
		} satisfies CreateCheckoutSessionRequest;

		try {
			const session = await this.checkout.PaymentsApi.sessions(checkoutConfig);
			strapi.log.info("adyen-api: " + JSON.stringify({ session }));
			return session;
		} catch (error) {
			// Handle errors and potentially increment a counter for failed session creations
			strapi.log.error("adyen-api: " + JSON.stringify({ error }));
			throw error;
		}
	}

	async handleShopperRedirect(redirect: any) {
		const details: PaymentCompletionDetails = {};

		strapi.log.verbose("adyen-api: redirecting customer after checkout");
		strapi.log.verbose(redirect);

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

	async handleWebhook(req: NotificationRequest) {
		strapi.log.verbose("adyen-api: " + JSON.stringify({ req }));
		const validator = new HmacValidator();
		const notification = req.notificationItems[0].NotificationRequestItem;

		if (!validator.validateHMAC(notification, this.hmacKey)) {
			strapi.log.error("adyen-api:" + JSON.stringify({ notification }));
			throw new Error("Could not validate webhook event");
		}

		return await this.consumeEvent(notification);
	}

	getClientKey() {
		return this.clientKey;
	}

	private async consumeEvent(notification: NotificationRequestItem) {
		const { merchantReference: uuid, eventCode } = notification;
		strapi.log.info("adyen-api: recieved valid webhook event");
		strapi.log.verbose(`adyen-api: ${JSON.stringify({ uuid, eventCode })}`);

		if (eventCode === EventCodeEnum.Authorisation) {
			// Update order
			strapi.log.error("adyen-api: consumeEvent() for EventCodeEnum.Authorisation NOT IMPLEMENTED");
			return { message: "success" };
		} else {
			strapi.log.error("adyen-api: consumeEvent() for any other event NOT IMPLEMENTED");
			return { message: "failed" };
		}
	}
}

export const adyenApi = new AdyenApi(adyenApiKey, adyenClientKey, adyenHmacKey, adyenEnvironment);

export type AdyenApiOptions = {
	apiKey: string;
	clientKey: string;
	hmacKey: string;
	environment: string;
};
