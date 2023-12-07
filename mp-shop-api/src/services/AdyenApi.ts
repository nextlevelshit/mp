import {Client, Config, CheckoutAPI} from "@adyen/api-library";
import {depotApi} from "./DepotApi";
import {adyenApiKey, adyenEnvironment, adyenMerchantAccount, adyenClientKey, adyenHmacKey} from "../config/constants";
import {AdyenEnvironment, Order} from "../util/types";
import debug from "debug";
import {PaymentCompletionDetails} from "@adyen/api-library/lib/src/typings/checkout/paymentCompletionDetails";
import HmacValidator from "@adyen/api-library/lib/src/utils/hmacValidator";
import {NotificationItem} from "@adyen/api-library/lib/src/typings/notification/notificationItem";
import {ProductDto} from "../dto/ProductDto";
import {OrderDto, OrderDtoData} from "../dto/OrderDto";

const logger = debug("mp:i:shop-api:adyen-api");
const verbose = debug("mp:v:shop-api:adyen-api");

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
		this.clientKey = hmacKey;
	}

	async createSessionOrThrow(protocol: string, host: string, order: OrderDto) {
		const orderRef = order.uuid;

		if (!order?.total) throw new Error("Cart is empty or has no total");

		verbose(`Creating checkout for cart ID "${order.id}" with total "${order.total}"`);

		return await this.checkout.PaymentsApi.sessions({
			amount: {currency: "EUR", value: (order.total * 100)},
			countryCode: "DE",
			merchantAccount: adyenMerchantAccount,
			reference: orderRef,
			returnUrl: `${protocol}://${host}/v1/cart/${orderRef}/redirect/?orderRef=${orderRef}&sessionId=${orderRef}`,
		});
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

		this.consumeEvent(notification);

		return { statusCode: 200, message: '[accepted]' };
	}

	private consumeEvent(notification: any) {
		const merchantReference = notification.merchantReference;
		const eventCode = notification.eventCode;
		verbose('merchantReference:' + merchantReference + " eventCode:" + eventCode);
		// Add item to DB, queue, or different thread
	}
}

export const adyenApi = new AdyenApi(adyenApiKey, adyenClientKey, adyenHmacKey, adyenEnvironment);
