export const adyenApiKey = process.env.ADYEN_API_KEY!;
export const adyenMerchantAccount = process.env.ADYEN_MERCHANT_ACCOUNT!;
export const adyenClientKey = process.env.ADYEN_CLIENT_KEY!;
export const adyenEnvironment = process.env.ADYEN_ENVIRONMENT || "TEST";
export const expressTrustProxy = process.env.SHOP_API_EXPRESS_TRUST_PROXY || "loopback, linklocal, uniquelocal";
export const port = process.env.SHOP_API_PORT || 8888;

debugger;
export const depotBearerToken = process.env.DEPOT_TOKEN!;
export const depotPort = process.env.DEPOT_PORT!;
