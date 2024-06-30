import { reactive } from "vue";
import { shopApi } from "@/services/ShopApi";
import { localStorageLabelCartUuid } from "@/config/constants";
import type { CartProduct, Order, Address } from "@/types";
import debug from "debug";

const logger = debug("app:i:cart-store");
const verbose = debug("app:v:cart-store");

const calculateCount = (products: CartProduct[] | null) =>
	products ? products.reduce((sum, { count }) => sum + count, 0) : 0;

// @ts-ignore
export const cart = reactive({
	uuid: "",
	products: [] as CartProduct[] | null,
	productsCount: 0,
	total: 0,
	subtotal: 0,
	VAT: 0,
	emailAddress: "",
	fetch() {
		verbose("Updating cart store");
		const uuidFromLocalStorage = localStorage.getItem(localStorageLabelCartUuid);

		shopApi
			.getOrCreateOrder(uuidFromLocalStorage)
			.then((order) => {
				this.overwrite(order);
			})
			.catch((error) => {
				logger("Error fetching or creating cart:", error);
				localStorage.removeItem(localStorageLabelCartUuid);
			});
	},
	overwrite(order: Order) {
		this.products = order.cartProducts;
		this.productsCount = calculateCount(this.products);
		this.total = order.delivery?.price
			? Math.round(order.total + order.delivery.price)
			: order.total;
		this.subtotal = order.subtotal;
		this.VAT = order.VAT;
		this.uuid = order.uuid;
		this.emailAddress = order.email ?? "";
		localStorage.setItem(localStorageLabelCartUuid, String(order.uuid));
	}
});
