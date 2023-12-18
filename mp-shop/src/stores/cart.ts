import { reactive } from "vue";
import {shopApi} from "@/services/ShopApi";
import {localStorageLabelCartUuid} from "@/config/constants";
import type {CartProduct, Order} from "@/types";
import debug from "debug";

const logger = debug("app:i:cart-store");
const verbose = debug("app:v:cart-store");

const calculateCount = (products: CartProduct[] | null) => products ? products.reduce((sum, {count}) => sum + count, 0) : 0;

export const cart = reactive({
	uuid: "",
	products: [] as CartProduct[] | null,
	productsCount: 0,
	total: "",
	subtotal: "",
	VAT: "",
	fetch() {
		verbose("Updating cart store");
		const uuidFromLocalStorage = localStorage.getItem(localStorageLabelCartUuid);

		shopApi.getOrCreateOrder(uuidFromLocalStorage).then((order) => {
			this.overwrite(order);
		}).catch((error) => {
			logger("Error fetching or creating cart:", error);
			localStorage.removeItem(localStorageLabelCartUuid);
		});
	},
	overwrite(order: Order) {
		this.products = order.cartProducts;
		this.productsCount = calculateCount(this.products);
		this.total = order.total?.toFixed(2);
		this.subtotal = order.subtotal?.toFixed(2);
		this.VAT = order.VAT?.toFixed(2);
		this.uuid = order.uuid;
		localStorage.setItem(localStorageLabelCartUuid, String(order.uuid));
	}
})
