// import * as process from "process";

class DepotApi {
    baseUrl: string;
    headers: Headers;

    constructor(options: DepotApiOptions) {
        this.baseUrl = options.baseUrl;
        this.headers = options.defaultHeaders ?? {};
    }

    async customers() {
        return fetch(`${this.baseUrl}/customers`, {
            method: "GET",
            headers: this.headers
        }).then((response) => {
            if (response.ok) {
                return response.json();
            }
        })
            .then(({data}) => {
                return data
            })
            .catch((error) => {
                console.error(error);
            });
    }

    async invoices() {
        return fetch(`${this.baseUrl}/invoices`, {
            method: "GET",
            headers: this.headers
        }).then((response) => {
            if (response.ok) {
                return response.json();
            }
        })
            .then(({data}) => {
                return data
            })
            .catch((error) => {
                console.error(error);
            });
    }

    get routes() {
        return new Map([
            ["customers", this.customers()],
            ["invoices", this.invoices()],
        ])
    }

    get(path: DepotApiRoutes) {
        return this.routes.get(path);
    }
}

export enum DepotApiRoutes {
    CUSTOMERS =  "customers"
}

interface DepotApiOptions {
    baseUrl: string;
    defaultHeaders?: Headers;
}

type Headers = Record<string, string>

export const depotApi = new DepotApi({
    baseUrl: import.meta.env.VITE_DEPOT_API_RELATIVE_PATH,
    defaultHeaders: {
        Authorization: `Bearer ${import.meta.env.VITE_DEPOT_API_TOKEN}`
    }
})