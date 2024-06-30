export const localStorageLabelCartUuid = "mp-shop:cart";
export const baseUrl = import.meta.env.VITE_BASE_URL!;
export const paymentEnvironment =
	import.meta.env.VITE_PAYMENT_ENVIRONMENT!.toLowerCase() as "live" | "test";
export const bookletCoverId = parseInt(import.meta.env.VITE_BOOKLET_COVER_ID!);
export const softCoverId = parseInt(import.meta.env.VITE_SOFT_COVER_ID!);
export const hardCoverId = parseInt(import.meta.env.VITE_HARD_COVER_ID!);
export const shopApiToken = import.meta.env.VITE_SHOP_API_TOKEN!;
