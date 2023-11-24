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
			data: null | {
				id: number;
				attributes: {
					name: string;
					price: number;
					createdAt: string;
					updatedAt: string;
				};
			};
		};
		payment: {
			data: null | {
				id: number;
				attributes: {
					name: string;
					price: number;
					createdAt: string;
					updatedAt: string;
				};
			};
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
	};
}

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
		createdAt: string;
		updatedAt: string;
	};
}

export interface Product {
	id: number;
	attributes: {
		name: string;
		description: string | null;
		price: number | null;
		createdAt: string;
		updatedAt: string;
		publishedAt: string;
		slug: string | null;
		cover: {
			data: {
				id: number;
				attributes: {
					price: number;
				};
			};
		};
		// payment: {
		//     data: {
		//         id: string;
		//         attributes: {
		//             name: string;
		//             price: number;
		//         };
		//     };
		// };
		// delivery: {
		//     data: {
		//         id: string;
		//         attributes: {
		//             name: string;
		//             price: number;
		//         };
		//     };
		// };
	};
}
