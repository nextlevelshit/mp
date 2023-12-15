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
	delivery: DeliveryMethodDtoData | null;
	payment: PaymentMethodDtoData | null;
	customer: {
		id: number;
		attributes: {
			Name: string;
			Address: string;
		};
	} | null;
	cartProducts: CartProductDtoData[] | null;
	paymentAuthorised: boolean;
	paymentStatus: string | null;
}
