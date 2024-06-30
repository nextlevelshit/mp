import type {
	ProductShared,
	OrderShared,
	ProductCoverShared,
	ProductPagesShared
} from "@/shared";

export interface MediaDataUnsafe {
	id: number;
	attributes: {
		name: string;
		alternativeText: string | null;
		caption: string | null;
		width: number | null;
		height: number | null;
		formats: {
			[key: string]: {
				ext: string;
				url: string;
				hash: string;
				mime: string;
				size: number;
				width: number;
				height: number;
			} | null;
		} | null;
		hash: string;
		ext: string;
		mime: string;
		size: number;
		url: string;
		previewUrl: string | null;
		provider: string;
		provider_metadata: any | null;
	};
}

export interface MediaData {
	id: number;
	name: string;
	alternativeText: string | null;
	caption: string | null;
	width: number | null;
	height: number | null;
	formats: {
		[key: string]: {
			ext: string;
			url: string;
			hash: string;
			mime: string;
			size: number;
			width: number;
			height: number;
		} | null;
	} | null;
	hash: string;
	ext: string;
	mime: string;
	size: number;
	url: string;
	previewUrl: string | null;
	provider: string;
	provider_metadata: any | null;
}

export interface DeliveryMethod {
	id: number;
	name: string;
	price: number;
	description: string | null;
}

export interface PaymentMethod {
	id: number;
	name: string;
	price: number;
	description: string | null;
}

export type Product = ProductShared;

export interface CartProduct {
	id: number;
	count: number;
	product: Product;
}

export type ProductCover = ProductCoverShared;

export type Order = OrderShared;

export type OrderUpdateBody = Partial<Order>;

export interface ProductVariantResponse {
	pages: ProductPagesShared[];
	cover: {
		id: number;
		name: string;
		binding: string;
		price: number;
		icon: {
			id: number;
			name: string;
			alternativeText: string | null;
			caption: string | null;
			width: number;
			height: number;
			formats: string | null;
			hash: string;
			ext: string;
			mime: string;
			size: number;
			url: string;
			previewUrl: string | null;
			provider: string;
			providerMetadata: string | null;
		};
		productVariant: {
			id: number;
			name: string;
			cover: number;
			ruling: number;
			pages: number;
			pattern: number;
		};
	}[];
	ruling: {
		id: number;
		name: string;
		price: number;
		icon: {
			id: number;
			name: string;
			alternativeText: string | null;
			caption: string | null;
			width: number;
			height: number;
			formats: string | null;
			hash: string;
			ext: string;
			mime: string;
			size: number;
			url: string;
			previewUrl: string | null;
			provider: string;
			providerMetadata: string | null;
		} | null;
		productVariant: {
			id: number;
			name: string;
			cover: number;
			ruling: number;
			pages: number;
			pattern: number;
		};
	}[];
}

export interface PatternVariantsResponse {
	patterns: {
		id: number;
		name: string;
		description: string;
		image: {
			id: number;
			url: string;
		};
		productVariant?: {
			id: number;
			name: string;
			cover: number;
			ruling: number;
			pages: number;
			pattern: number;
		};
	}[];
}

export interface Address {
	name: string;
	surname: string;
	street: string;
	postalCode: string;
	city: string;
}

export type Legal = Record<LegalPage, string>;
export type LegalPage =
	| "imprint"
	| "contact"
	| "terms"
	| "privacy"
	| "delivery"
	| "payment";

export type Content = Record<LegalPage, string>;
export type ContentPage = "production";
