import type {ListDto} from "@/dto/Common";

export class OrderListDto implements ListDto<OrderListItem> {
    list: OrderListItem[];

    transformer(item: OrderListItem) {
        return [
            item.attributes.products.data.length.toString(),
            item.attributes.address,
            item.attributes.invoiceAddress,
            item.attributes.delivery.data?.attributes.name ?? "",
            item.attributes.payment.data?.attributes.name ?? "",
            `${item.attributes.total} EUR`,
            new Date(item.attributes.createdAt).toLocaleDateString()
        ];
    }

    header = [
        "Produkte",
        "Lieferadresse",
        "Rechnungsadresse",
        "Versandart",
        "Zahlung",
        "Gesamt",
        "Datum"
    ];
    title = "Bestellungen";
    options = new Map([
        ["Alle", {query: "all"}],
        ["Geschlossen", {query: ""}],
        ["Offen", {query: "all "}]
    ]);
    editLink = (id: number) => `/edit/order/${id}`;

    constructor(list: OrderListItem[]) {
        this.list = list;
    }

    get rows(): string[][] {
        return this.list.map(this.transformer);
    }

    get length() {
        return this.list.length;
    }

    static toFormInput(orderData: OrderListItem) {
        const {total, subtotal, VAT, delivery, payment} = orderData.attributes;

        return {
            total,
            subtotal,
            VAT,
            delivery: delivery.data?.id,
            payment: payment.data?.id
        };
    }
}

export interface OrderListItem {
    id: number;
    attributes: {
        Date: string;
        createdAt: string;
        updatedAt: string;
        email: string | null;
        address: string;
        invoiceAddress: string;
        VAT: number;
        subtotal: number | null;
        total: number | null;
        invoice: {
            data: null | MediaData;
        };
        deliveryNote: {
            data: null | MediaData;
        };
        products: {
            data: ProductData[];
        };
        delivery: {
            data: {
                id: number;
                attributes: {
                    name: string;
                    price: number;
                    createdAt: string;
                    updatedAt: string;
                };
            } | null;
        };
        payment: {
            data: {
                id: number;
                attributes: {
                    name: string;
                    price: number;
                    createdAt: string;
                    updatedAt: string;
                };
            } | null;
        };
    };
}

export interface MediaData {
    id: number;
    attributes: {
        name: string;
        alternativeText: string | null;
        caption: string | null;
        width: number | null;
        height: number | null;
        formats: {
            [key: string]: {
                ext: string;
                url: string;
                hash: string;
                mime: string;
                size: number;
                width: number;
                height: number;
            } | null;
        } | null;
        hash: string;
        ext: string;
        mime: string;
        size: number;
        url: string;
        previewUrl: string | null;
        provider: string;
        provider_metadata: any | null;
        createdAt: string;
        updatedAt: string;
    }
}

export interface ProductData {
    id: number;
    attributes: {
        name: string;
        description: string | null;
        price: number | null;
        createdAt: string;
        updatedAt: string;
        publishedAt: string;
        slug: string | null;
        cover: {
            data: {
                id: number;
                attributes: {
                    price: number;
                };
            };
        };
        payment: {
            data: {
                id: string;
                attributes: {
                    name: string;
                    price: number;
                };
            };
        };
        delivery: {
            data: {
                id: string;
                attributes: {
                    name: string;
                    price: number;
                };
            };
        };
    };
}
