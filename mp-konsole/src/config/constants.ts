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
    list: CustomerListItem[];
    config = (item: CustomerListItem): string[] => (
        [item.attributes.Name, item.id, item.attributes.Address]
    );

    constructor(options: CustomerListItem[]) {
        this.list = options;
    }

    get title() {
        return "Kundenadressen"
    }

    get header(): string[] {
        return ["Name", "Adresse"]
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