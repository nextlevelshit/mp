import {AdyenEnvironment} from "../types";

export const adyenApiKey = process.env.ADYEN_API_KEY!;
export const adyenMerchantAccount = process.env.ADYEN_MERCHANT_ACCOUNT!;
export const adyenClientKey = process.env.ADYEN_CLIENT_KEY!;
export const adyenEnvironment = process.env.ADYEN_ENVIRONMENT as AdyenEnvironment || "TEST";
export const adyenHmacKey = process.env.ADYEN_HMAC_KEY!;
export const expressTrustProxy = process.env.EXPRESS_TRUST_PROXY || "loopback, linklocal, uniquelocal";
export const port = 8888;
export const depotBearerToken = process.env.DEPOT_TOKEN!;
export const depotPort = process.env.DEPOT_PORT!;
export const inkassoPort = process.env.INKASSO_PORT!;
export const postamtPort = process.env.POSTAMT_PORT!;
export const umamiAddress = process.env.UMAMI_ADDRESS!;
export const depotAddress = `http://mp-depot:${depotPort}`;
export const inkassoAddress = `http://mp-inkasso:${inkassoPort}`;
export const postamtAddress = `http://mp-postamt:${postamtPort}`;
// TODO: Should be retrieved from DepotApi
export const vatIncludedDecimal = 1.19;
// TODO: Should be retrieved from DepotApi
export const vatDecimal = 0.19;
