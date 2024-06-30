import { GetValues, GetPopulatableKeys, GetNonPopulatableKeys } from "@strapi/types/dist/types/core/attributes";
import { NotificationItem } from "@adyen/api-library/lib/src/typings/notification/notificationItem";

export type AdyenEnvironment = "TEST" | "LIVE";
export type Order = GetValues<"api::order.order", GetNonPopulatableKeys<"api::order.order"> | GetPopulatableKeys<"api::order.order">>;
export type OrderSafe = GetValues<"api::order.order", GetPopulatableKeys<"api::order.order">>;
export type Product = GetValues<"api::product.product", GetNonPopulatableKeys<"api::product.product"> | GetPopulatableKeys<"api::product.product">>;
export type ProductPattern = GetValues<
	"api::product-pattern.product-pattern",
	GetNonPopulatableKeys<"api::product-pattern.product-pattern"> | GetPopulatableKeys<"api::product-pattern.product-pattern">
>;
export type ProductPages = GetValues<
	"api::product-page.product-page",
	GetNonPopulatableKeys<"api::product-page.product-page"> | GetPopulatableKeys<"api::product-page.product-page">
>;
export type ProductRuling = GetValues<
	"api::product-ruling.product-ruling",
	GetNonPopulatableKeys<"api::product-ruling.product-ruling"> | GetPopulatableKeys<"api::product-ruling.product-ruling">
>;
export type ProductCover = GetValues<
	"api::product-cover.product-cover",
	GetNonPopulatableKeys<"api::product-cover.product-cover"> | GetPopulatableKeys<"api::product-cover.product-cover">
>;

export type PdfBody = {
	subject: string;
	date: string;
	to: {
		name: string;
		address: string[];
	};
	nr: {
		customer: string;
		order: string;
		shipping?: string;
		invoice?: string;
	};
	service: {
		description: string;
		price: {
			per_unit: number;
			total: number;
		};
		count: number;
		nr: string;
	}[];
	currency: "\\euro";
	body?: string;
	total: number;
	subtotal: number;
	VAT: {
		rate: number;
		amount: number;
	};
};

export interface NotificationRequest {
	live: boolean;
	notificationItems: NotificationItem[];
}
