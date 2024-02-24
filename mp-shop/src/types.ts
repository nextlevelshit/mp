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
	cover: {
		id: number;
		name: string;
		binding: string;
		price: number;
		copyText: {
			text: string;
			cover: string;
			paper: string;
			format: string;
			content: string;
			details: string;
			banderole: string;
		};
	} | null;
	pattern: {
		id: number;
		name: string;
		description: string;
		price: number;
	} | null;
	pages: {
		id: number;
		name: string;
		price: number;
	} | null;
	ruling: {
		id: number;
		name: string;
		price: number;
	} | null;
	image: MediaData;
	totalProductPrice: number;
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
	invoice: MediaDataUnsafe | null;
	deliveryNote: MediaDataUnsafe | null;
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
	acceptedTermsAndConditionsAt: string;
}

export type OrderUpdateBody = Partial<Order>;

export interface ProductVariantResponse {
	allProductVariants: {
		id: number;
		name: string;
		cover: number;
		ruling: number;
		pages: number;
		pattern: number;
	}[];
	pages: {
		id: number;
		name: string;
		price: number;
		productVariant: {
			id: number;
			name: string;
			cover: number;
			ruling: number;
			pages: number;
			pattern: number;
		};
	}[];
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

export interface Address {
	name: string;
	surname: string;
	street: string;
	postalCode: string;
	city: string;
}
