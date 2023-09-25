import type { MediaData, OrderListItem, ProductData } from "@/dto/OrderListDto";

export class OrderViewDto {
	raw: OrderListItem;
	data: {
		total: number;
		subtotal: number;
		VAT: number;
		delivery: number;
		payment: number;
	} = {
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

	digest(order: OrderListItem) {
		const { total, subtotal, VAT, delivery, payment } = order.attributes;

		return {
			total: total ?? 0,
			subtotal: subtotal ?? 0,
			VAT,
			delivery: delivery.data?.id ?? -1,
			payment: payment.data?.id ?? -1
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

	resetInvoice() {
		this.raw.attributes.invoice.data = null;
	}

	resetDeliveryNote() {
		this.raw.attributes.deliveryNote.data = null;
	}
}
