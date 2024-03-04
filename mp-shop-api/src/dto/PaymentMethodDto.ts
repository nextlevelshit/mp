import { PaymentMethod } from "../types";

export class PaymentMethodDto {
	private readonly paymentMethod: PaymentMethod;

	constructor(paymentMethod: PaymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	get id(): number {
		return this.paymentMethod.id;
	}

	get name(): string {
		return this.paymentMethod.attributes.name;
	}

	get price(): number {
		return this.paymentMethod.attributes.price;
	}

	get description(): string | null {
		return this.paymentMethod.attributes.description ?? null;
	}

	get dto(): PaymentMethodDtoData {
		return {
			id: this.id,
			name: this.name,
			price: this.price,
			description: this.description
		};
	}
}

export interface PaymentMethodDtoData {
	id: number;
	name: string;
	price: number;
	description: string | null;
}
