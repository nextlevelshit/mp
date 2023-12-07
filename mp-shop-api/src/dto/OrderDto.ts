import {MediaData, Order} from "../util/types";
import {ProductDto, ProductDtoData} from "./ProductDto";
import {DeliveryMethodDto, DeliveryMethodDtoData} from "./DeliveryMethodDto";
import {PaymentMethodDto, PaymentMethodDtoData} from "./PaymentMethodDto";
import debug from "debug";
import {vatIncludedFactor, vatFactor} from "../config/constants";


const logger = debug("mp:i:shop-api:order-dto");
const verbose = debug("mp:v:shop-api:order-dto");

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
		const products = this.products ? this.products.map((product) => product.dto) : null;
		const delivery = this.delivery ? this.delivery?.dto : null;
		const payment = this.payment ? this.payment?.dto : null;

		let subtotal = -1;
		let total = -1;
		let VAT = -1;

		if (products && delivery && payment) {
			const productsTotal = products.reduce((v, p) => (v + p.totalProductPrice), 0);

			total = Math.round((productsTotal + delivery.price + payment.price) * 100) / 100;
			VAT = Math.round(total / vatIncludedFactor * vatFactor * 100) / 100;
			subtotal = Math.round((total - VAT) * 100) / 100;
			verbose(total, subtotal, VAT);
		}

		return {
			id: this.id,
			createdAt: this.createdAt,
			updatedAt: this.updatedAt,
			total,
			subtotal,
			VAT,
			delivery,
			payment,
			products,
			date: this.date,
			email: this.email,
			address: this.address,
			invoiceAddress: this.invoiceAddress,
			uuid: this.uuid,
			invoice: this.invoice,
			deliveryNote: this.deliveryNote,
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
	subtotal: number;
	total: number;
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
