export const localStorageLabelCartUuid = "mp-shop:cart";
export const paymentEnvironment: "live" | "test" = (import.meta.env.VITE_PAYMENT_ENVIRONMENT! as string).toLowerCase();
