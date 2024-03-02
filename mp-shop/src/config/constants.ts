export const localStorageLabelCartUuid = "mp-shop:cart";
export const paymentEnvironment = (import.meta.env.VITE_PAYMENT_ENVIRONMENT! as string).toLowerCase() as "live" | "test";
