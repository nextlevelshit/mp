export interface Order {
	id: number;
	attributes: {
		Date: string;
		createdAt: string;
		updatedAt: string;
		email: string | null;
		address: string;
		invoiceAddress: string;
		VAT: number;
		subtotal: number | null;
		total: number | null;
		uuid: string;
		invoice: {
			data: null | MediaData;
		};
		deliveryNote: {
			data: null | MediaData;
		};
		products: {
			data: Product[];
		};
		delivery: {
			data: null | DeliveryMethod;
		};
		payment: {
			data: null | PaymentMethod;
		};
		customer: {
			data: null | {
				id: number;
				attributes: {
					Name: string;
					Address: string;
				};
			};
		};
		cart: null | CartProduct[];
		paymentAuthorised: boolean;
		paymentStatus: null | string;
		emailSent: boolean;
	};
}

export interface OrderUpdate {
	email: string;
	address: string;
	invoiceAddress: string;
	delivery: number;
	payment: number;
	customer: any;
	cart: null | {
		count: number;
		product: number;
	}[];
	paymentAuthorised: boolean;
	paymentStatus: string | boolean;
	Date: string;
	emailSent: boolean;
}

export interface OrderUpdateCalculated {
	subtotal: number;
	VAT: number;
	total: number;
}

export type OrderUpdatedTotalRequest = Partial<OrderUpdate> | OrderUpdateCalculated;

export interface MediaData {
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

export interface Product {
	id: number;
	attributes: {
		name: string;
		description: string | null;
		price: number | null;
		publishedAt: string;
		slug: string | null;
		cover: {
			data: null | ProductCover;
		};
		pattern: {
			data: null | ProductPattern;
		};
		pages: {
			data: null | ProductPages;
		};
		ruling: {
			data: null | ProductRuling;
		};
		image: {
			data: MediaData;
		};
	};
}

export interface ProductCover {
	id: number;
	attributes: {
		name: string;
		binding: string;
		price: number;
		createdAt: string;
		updatedAt: string;
		copyText: {
			text: string;
			cover: string;
			paper: string;
			format: string;
			content: string;
			details: string;
			banderole: string;
		};
	};
}

export interface ProductRuling {
	id: number;
	attributes: {
		name: string;
		price: number;
	};
}

export interface PaymentMethod {
	id: number;
	attributes: {
		name: string;
		price: number;
	};
}

export interface DeliveryMethod {
	id: number;
	attributes: {
		name: string;
		price: number;
	};
}

export interface ProductPattern {
	id: number;
	attributes: {
		name: string;
		description: string;
		price?: number;
	};
}

export interface ProductPages {
	id: number;
	attributes: {
		name: string;
		price: number;
	};
}

export type AdyenEnvironment = "TEST" | "LIVE";

export interface CartProduct {
	id: number;
	count: number;
	product: {
		data: Product
	};
}

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
	}
};
