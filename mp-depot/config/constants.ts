import type {AdyenEnvironment} from "../types";


export const adyenApiKey = process.env.ADYEN_API_KEY!;
export const adyenMerchantAccount = process.env.ADYEN_MERCHANT_ACCOUNT!;
export const adyenClientKey = process.env.ADYEN_CLIENT_KEY!;
export const adyenEnvironment = process.env.ADYEN_ENVIRONMENT as AdyenEnvironment || "TEST";
export const adyenHmacKey = process.env.ADYEN_HMAC_KEY!;

// TODO: Should be retrieved from DepotApi
export const vatIncludedDecimal = 1.19;
// TODO: Should be retrieved from DepotApi
export const vatDecimal = 0.19;
