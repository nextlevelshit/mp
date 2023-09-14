export const depotApiBaseUrl = import.meta.env.VITE_DEPOT_API_RELATIVE_PATH;
export const depotApiBearerToken = import.meta.env.VITE_DEPOT_API_TOKEN;

export class InvoiceListDto {
    constructor(options: InvoiceListDtoOptions) {
    }

    header(): string[] {
        return []
    }

    rows() {

    }
}

export interface InvoiceListDtoOptions {
}

export class CustomerListDto {
    config = (item: CustomerListItem): string[] => (
        [item.attributes.Name, item.id, item.attributes.Address]
    );
    header = ["Name", "ID", "Adresse"];
    list: CustomerListItem[];
    title = "Kundenadressen";
    options = new Map([
        ["Alle", {query: "all"}],
        ["Bestandskunden", {query: ""}],
        ["Neue", {query: "all "}]
    ]);

    constructor(options: CustomerListItem[]) {
        this.list = options;
    }

    get rows() {
        return this.list.map(this.config);
    }

    get length() {
        return this.list.length;
    }
}

export interface CustomerListItem {
    id: string;
    attributes: {
        Name: string;
        Address: string;
    }
}