import type { OrderListItem, ProductData } from "@/dto/OrderListDto";
import debug from "debug";

export class OrderViewDto {
	logger = debug("app:i:order-view-dto");
	raw: OrderListItem;
	data: OrderViewData = {
		total: 0,
		subtotal: 0,
		VAT: 0,
		delivery: -1,
		payment: -1
	};

	constructor(rawApiResponse: OrderListItem) {
		this.raw = rawApiResponse;
		this.data = this.digest(rawApiResponse);
	}

	digest(order: OrderListItem): OrderViewData {
		const {
			total,
			subtotal,
			VAT,
			delivery,
			payment,
			address,
			invoiceAddress,
			Date: date
		} = order.attributes;

		return {
			total: total ?? 0.0,
			subtotal: subtotal ?? 0.0,
			delivery: delivery.data?.id ?? -1,
			payment: payment.data?.id ?? -1,
			address: address ? address : this.customer?.address,
			invoiceAddress: invoiceAddress ? invoiceAddress : this.customer?.address,
			Date: new Date(date).toISOString().split("T")[0],
			VAT
		};
	}

	get nr() {
		const fillWithZeros = (id: number, targetLength = 4) => {
			return (id + "").padStart(targetLength, "0");
		};

		const thisYear = new Date().getFullYear().toString().slice(-2);

		const customer = fillWithZeros(this.raw.attributes.customer.data?.id ?? 0);
		const order = fillWithZeros(this.raw.id);
		const invoice = `${customer}/${order}/${thisYear}`;

		this.logger(this.raw.attributes.invoice.data);

		return {
			invoice,
			customer,
			order,
			shipping: invoice
		};
	}

	get invoice() {
		const {
			invoice: { data }
		} = this.raw.attributes;

		if (data) {
			const {
				id,
				attributes: { url, createdAt }
			} = data;

			return {
				id,
				createdAt: new Date(createdAt).toLocaleString(),
				url
			};
		}

		return null;
	}

	get deliveryNote() {
		const {
			deliveryNote: { data }
		} = this.raw.attributes;

		if (data) {
			const {
				id,
				attributes: { url, createdAt }
			} = data;

			return {
				id,
				createdAt: new Date(createdAt).toLocaleString(),
				url
			};
		}

		return null;
	}

	get products(): ProductData[] {
		return this.raw.attributes.products.data;
	}

	// get deliveryAddress() {
	// 	return this.raw.attributes.address;
	// }
	//
	// get invoiceAddress() {
	// 	return this.raw.attributes.invoiceAddress;
	// }

	get customer() {
		if (!this.raw.attributes.customer.data) return null;

		const { id, attributes } = this.raw.attributes.customer.data;

		return {
			id,
			name: attributes.Name,
			address: attributes.Address
		};
	}

	resetInvoice() {
		this.raw.attributes.invoice.data = null;
	}

	resetDeliveryNote() {
		this.raw.attributes.deliveryNote.data = null;
	}
}

interface OrderViewData {
	total: number;
	subtotal: number;
	VAT: number;
	delivery: number;
	payment: number;
	invoiceAddress?: string;
	address?: string;
	Date?: string;
}
