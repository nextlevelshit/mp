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

export interface DeliveryMethod {
	id: number;
	name: string;
	price: number;
}

export interface PaymentMethod {
	id: number;
	name: string;
	price: number;
}

export interface Product {
	id: number;
	name: string;
	description: string | null;
	price: number | null;
	publishedAt: string;
	slug: string | null;
	cover: ProductCoverDtoData | null;
	pattern: ProductPatternDtoData | null;
	pages: ProductPagesDtoData | null;
	ruling: ProductRulingDtoData | null;
	image: MediaDataDtoData;
	totalProductPrice: number
}

export interface CartProduct {
	id: number;
	count: number;
	product: Product;
}


export interface Order {
	id: number;
	date: string;
	createdAt: string;
	updatedAt: string;
	email: string | null;
	address: string;
	invoiceAddress: string;
	VAT: number;
	subtotal: number;
	total: number;
	uuid: string;
	invoice: MediaData | null;
	deliveryNote: MediaData | null;
	delivery: DeliveryMethod | null;
	payment: PaymentMethod | null;
	customer: {
		id: number;
		attributes: {
			Name: string;
			Address: string;
		};
	} | null;
	cartProducts: CartProduct[] | null;
	paymentAuthorised: boolean;
	paymentStatus: string | null;
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
		shipping: string;
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
	currency: string;
	body: string;
	total: number;
	subtotal: number;
	VAT: {
		rate: number;
		amount: number;
	}
};
