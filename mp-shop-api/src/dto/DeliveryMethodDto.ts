import {DeliveryMethod} from "../types";

export class DeliveryMethodDto {
	private readonly deliveryMethod: DeliveryMethod;

	constructor(deliveryMethod: DeliveryMethod) {
		this.deliveryMethod = deliveryMethod;
	}

	get id(): number {
		return this.deliveryMethod.id;
	}

	get name(): string {
		return this.deliveryMethod.attributes.name;
	}

	get price(): number {
		return this.deliveryMethod.attributes.price;
	}
	get dto(): DeliveryMethodDtoData {
		return {
			id: this.id,
			name: this.name,
			price: this.price,
		};
	}
}

export interface DeliveryMethodDtoData {
	id: number;
	name: string;
	price: number;
}
