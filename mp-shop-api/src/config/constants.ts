import {AdyenEnvironment} from "../util/types";

export const adyenApiKey = process.env.ADYEN_API_KEY!;
export const adyenMerchantAccount = process.env.ADYEN_MERCHANT_ACCOUNT!;
export const adyenClientKey = process.env.ADYEN_CLIENT_KEY!;
export const adyenEnvironment = process.env.ADYEN_ENVIRONMENT as AdyenEnvironment || "TEST";
export const adyenHmacKey = process.env.ADYEN_HMAC_KEY!;
export const expressTrustProxy = process.env.SHOP_API_EXPRESS_TRUST_PROXY || "loopback, linklocal, uniquelocal";
export const port = process.env.SHOP_API_PORT || 8888;
export const depotBearerToken = process.env.SHOP_API_DEPOT_TOKEN!;
export const depotPort = process.env.DEPOT_PORT!;
export const inkassoPort = process.env.INKASSO_PORT!;
export const postamtPort = process.env.POSTAMT_PORT!;
// TODO: Should be retrieved from DepotApi
export const vatIncludedDecimal = 1.19;
// TODO: Should be retrieved from DepotApi
export const vatDecimal = 0.19;
