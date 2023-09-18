import {BaseListDto} from "@/dto/ListDto";
import type {ListItem} from "@/dto/ListDto";
import type {CustomerListItem} from "@/dto/CustomerListDto";
import type {InvoiceListItem} from "@/dto/InvoiceListDto";

export class OrderListDto extends BaseListDto<OrderListItem> {
    transformer = (item: OrderListItem) => {
		const customer = item.attributes.cart.data;
        return [
			new Date(item.attributes.createdAt).toDateString(),
            customer ? customer.attributes.UUID : "Keine Daten",
            item.attributes.customer ? "Kundendaten hinterlegt" : "Anonym"
        ]
    };
    title = "Bestellungen";
    header = ["Datum", "Warenkorb", "Status"];
    options = new Map([
        ["Alle", {query: "all"}],
        ["Geschlossen", {query: ""}],
        ["Offen", {query: "all "}]
    ]);

    constructor(list: OrderListItem[]) {
        super(list);
    }
}

export interface OrderListItem extends ListItem {
    attributes: {
        Date: string;
        createdAt: string;
        customer: {
            data: CustomerListItem;
        };
        invoice: {
            data: InvoiceListItem;
        };
        cart: {
            data: {
                id: string;
                attributes: {
                    UUID: string;
                    updatedAt: string;
                };
            };
        };
    };
}
