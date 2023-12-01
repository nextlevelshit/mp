import {MediaData, Order} from "../util/types";
import {ProductDto, ProductDtoData} from "./ProductDto";
import {DeliveryMethodDto, DeliveryMethodDtoData} from "./DeliveryMethodDto";
import {PaymentMethodDto, PaymentMethodDtoData} from "./PaymentMethodDto";

export class OrderDto {
	private readonly order: Order;

	constructor(order: Order) {
		this.order = order;
	}

	get id(): number {
		return this.order.id;
	}

	get date(): string {
		return this.order.attributes.Date;
	}

	get createdAt(): string {
		return this.order.attributes.createdAt;
	}

	get updatedAt(): string {
		return this.order.attributes.updatedAt;
	}

	get email(): string | null {
		return this.order.attributes.email;
	}

	get address(): string {
		return this.order.attributes.address;
	}

	get invoiceAddress(): string {
		return this.order.attributes.invoiceAddress;
	}

	get VAT(): number {
		return this.order.attributes.VAT;
	}

	get subtotal(): number | null {
		return this.order.attributes.subtotal;
	}

	get total(): number | null {
		return this.order.attributes.total;
	}

	get uuid(): string {
		return this.order.attributes.uuid;
	}

	get invoice(): MediaData | null {
		return this.order.attributes.invoice.data;
	}

	get deliveryNote(): MediaData | null {
		return this.order.attributes.deliveryNote.data;
	}

	get products(): ProductDto[] | null {
		const products = this.order.attributes.products.data;
		return products ? products.map(product => new ProductDto(product)) : null;
	}

	get delivery(): DeliveryMethodDto | null {
		const deliveryMethodData = this.order.attributes.delivery.data;
		return deliveryMethodData ? new DeliveryMethodDto(deliveryMethodData) : null;
	}

	get payment(): PaymentMethodDto | null {
		const paymentMethodData = this.order.attributes.payment.data;
		return paymentMethodData ? new PaymentMethodDto(paymentMethodData) : null;
	}

	get customer(): {
		id: number;
		attributes: {
			Name: string;
			Address: string;
		};
	} | null {
		return this.order.attributes.customer.data;
	}

	get dto(): OrderDtoData {
		return {
			id: this.id,
			date: this.date,
			createdAt: this.createdAt,
			updatedAt: this.updatedAt,
			email: this.email,
			address: this.address,
			invoiceAddress: this.invoiceAddress,
			VAT: this.VAT,
			subtotal: this.subtotal,
			total: this.total,
			uuid: this.uuid,
			invoice: this.invoice,
			deliveryNote: this.deliveryNote,
			products: this.products ? this.products.map((product) => product.dto) : null,
			delivery: this.delivery ? this.delivery?.dto : null,
			payment: this.payment ? this.payment?.dto : null,
			customer: this.customer
				? {
					id: this.customer.id,
					attributes: {
						Name: this.customer.attributes.Name,
						Address: this.customer.attributes.Address,
					},
				}
				: null,
		};
	}
}

export interface OrderDtoData {
	id: number;
	date: string;
	createdAt: string;
	updatedAt: string;
	email: string | null;
	address: string;
	invoiceAddress: string;
	VAT: number;
	subtotal: number | null;
	total: number | null;
	uuid: string;
	invoice: MediaData | null;
	deliveryNote: MediaData | null;
	products: ProductDtoData[] | null;
	delivery: DeliveryMethodDtoData | null;
	payment: PaymentMethodDtoData | null;
	customer: {
		id: number;
		attributes: {
			Name: string;
			Address: string;
		};
	} | null;
}
