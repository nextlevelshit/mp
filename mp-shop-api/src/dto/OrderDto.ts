import {MediaData, Order, PdfBody} from "../types";
import {DeliveryMethodDto, DeliveryMethodDtoData} from "./DeliveryMethodDto";
import {PaymentMethodDto, PaymentMethodDtoData} from "./PaymentMethodDto";
import debug from "debug";
import {vatDecimal, vatIncludedDecimal} from "../config/constants";
import {CartProductDto, CartProductDtoData} from "./CartProductDto";


const logger = debug("app:i:shop-api:order-dto");
const verbose = debug("app:v:shop-api:order-dto");

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

	get emailSent(): boolean {
		return this.order.attributes.emailSent;
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

	get paymentAuthorised(): boolean {
		return this.order.attributes.paymentAuthorised;
	}

	get paymentStatus(): string | null {
		return this.order.attributes.paymentStatus;
	}

	get acceptedTermsAndConditionsAt(): string | null {
		return this.order.attributes.acceptedTermsAndConditionsAt;
	}

	get invoice(): MediaData | null {
		return  this.order.attributes.invoice.data;
	}

	get deliveryNote(): MediaData | null {
		return this.order.attributes.deliveryNote.data;
	}

	get cartProducts(): CartProductDto[] | null {
		const cartProducts = this.order.attributes.cart;
		return cartProducts ? cartProducts.map((cartProduct) => new CartProductDto(cartProduct)) : null;
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
		return this.order.attributes.customer?.data;
	}
	get invoicePdfBody(): PdfBody {
		const { id, date, email, invoiceAddress, VAT, subtotal, total, uuid } = this.dto;

		return {
			subject: "RECHNUNG",
			date,
			to: {
				name: "",
				address: invoiceAddress ? invoiceAddress.split("\n") : [],
			},
			nr: {
				customer: `${id}`,
				order: uuid,
				invoice: "123",
			},
			service: this.cartProducts?.map((cartProduct) => ({
				description: cartProduct.product.name,
				price: {
					per_unit: cartProduct.product.totalProductPrice() || 0,
					total: (cartProduct.product.totalProductPrice() || 0) * cartProduct.count,
				},
				count: cartProduct.count,
				nr: `${cartProduct.product.id}`,
			})) || [],
			currency: "\\euro",
			body: "Thank you for your purchase!",
			total,
			subtotal,
			VAT: {
				amount: VAT,
				rate: vatDecimal * 100
			}
		};
	}

	get deliveryNotePdfBody(): PdfBody {
		const { id, date, email, address, VAT, subtotal, total, uuid } = this.dto;

		return {
			subject: "LIEFERSCHEIN",
			date,
			to: {
				name: "",
				address: address ? address.split("\n") : []
			},
			nr: {
				customer: `${id}`,
				order: uuid,
				shipping: "123",
			},
			service: this.cartProducts?.map((cartProduct) => ({
				description: cartProduct.product.name,
				price: {
					per_unit: cartProduct.product.price || 0,
					total: (cartProduct.product.price || 0) * cartProduct.count,
				},
				count: cartProduct.count,
				nr: `${cartProduct.product.id}`,
			})) || [],
			currency: "\\euro",
			body: "Thank you for your purchase!",
			total,
			subtotal,
			VAT: {
				amount: VAT,
				rate: vatDecimal * 100
			}
		};
	}

	get dto(): OrderDtoData {
		const cartProducts = this.cartProducts ? this.cartProducts.map((cartProduct) => cartProduct.dto) : null;
		const delivery = this.delivery ? this.delivery.dto : null;
		const payment = this.payment ? this.payment.dto : null;

		let subtotal = -1;
		let total = -1;
		let VAT = -1;

		if (cartProducts) {
			const productsTotal = cartProducts.reduce((v, p) => (v + (p.product.totalProductPrice ?? 0) * p.count), 0);
			const deliveryPrice = delivery ? delivery.price : 0;
			const paymentPrice = payment ? payment.price : 0;

			total = Math.round((productsTotal + deliveryPrice + paymentPrice) * 100) / 100;
			VAT = Math.round(total / vatIncludedDecimal * vatDecimal * 100) / 100;
			subtotal = Math.round((total - VAT) * 100) / 100;
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
			cartProducts,
			paymentAuthorised: this.paymentAuthorised,
			paymentStatus: this.paymentStatus,
			acceptedTermsAndConditionsAt: this.acceptedTermsAndConditionsAt,
			date: this.date,
			email: this.email,
			emailSent: this.emailSent,
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
	emailSent: boolean;
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
	paymentAuthorised: boolean;
	paymentStatus: string | null;
	acceptedTermsAndConditionsAt: string | null;
	customer: {
		id: number;
		attributes: {
			Name: string;
			Address: string;
		};
	} | null;
	cartProducts: CartProductDtoData[] | null;
}
