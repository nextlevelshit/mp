import express from "express";
import {version} from "../package.json";
import {verbose} from "./util/logger";
import {depotApi} from "./services/DepotApi";

export const router = express.Router();

router.get("/v1", async (req, res) => {
	const today = new Date().toISOString().split("T")[0];

	res.send(`<h1>mp-shop-api v${version} - ${today}</h1>`);
});

router.post("/v1/cart/", async (req, res) => {
	try {
		const cart = await depotApi.orderFactory().create();

		res.status(201).send(cart.attributes.uuid);
	} catch (e) {
		res.status(500).send("Could not create cart");
	}
});

router.all("/v1/cart/:uuid", async (req, res) => {
	if (!req.params.uuid) res.status(422).send("Missing cart UUID");

	try {
		const {uuid} = req.params;

		switch (req.method) {
			case "GET":
				verbose(`Querying cart with UUID ${uuid}`);

				const order = await depotApi.orderFactory().one(uuid);

				res.status(200).send(order);
				break;
			case "PUT":
				verbose(`Updating cart with UUID ${uuid}`);

				if (!req.body) res.status(422).send("Missing data to be updated");

				const updatedOrder = await depotApi.orderFactory().update(uuid, req.body);

				res.status(200).send(updatedOrder);
				break;
			default:
				res.status(405).send("Method not allowed")
		}
	} catch (e) {
		res.status(500).send("Could not fetch cart");
	}
});

router.get("/v1/product", async (req, res) => {
	try {
		verbose(`Querying products`);

		const productList = await depotApi.productFactory().all({
			pagination: {
				start: 0,
				limit: 2
			},
			filters: {
				ruling: {
					id: {
						$eq: 3
					}
				},
				cover: {
					id: {
						$eq: 1
					}
				}
			}
		});

		res.status(200).send(productList);
	} catch (e) {
		res.status(500).send("Could not fetch cart");
	}
});

router.get("/v1/product/:id", async (req, res) => {
	try {
		const {id} = req.params;
		verbose(`Querying product with ID ${id}`);

		const product = await depotApi.productFactory().one(id);

		res.status(200).send(product);
	} catch (e) {
		res.status(500).send("Could not fetch cart");
	}
});

router.get("/v1/product-ruling", async (req, res) => {
	try {
		verbose(`Querying product rulings`);

		const productRulings = await depotApi.productRuling();

		res.status(200).send(productRulings);
	} catch (e) {
		res.status(500).send("Could not fetch product rulings");
	}
});

router.get("/v1/payment-method", async (req, res) => {
	try {
		verbose(`Querying payment methods`);

		const paymentMethod = await depotApi.paymentMethod();

		res.status(200).send(paymentMethod);
	} catch (e) {
		res.status(500).send("Could not fetch payment methods");
	}
});

router.get("/v1/delivery-method", async (req, res) => {
	try {
		verbose(`Querying delivery methods`);

		const deliveryMethods = await depotApi.deliveryMethod();

		res.status(200).send(deliveryMethods);
	} catch (e) {
		res.status(500).send("Could not fetch delivery methods");
	}
});

router.get("/v1/product-pattern", async (req, res) => {
	try {
		verbose(`Querying product patterns`);

		const patterns = await depotApi.productPattern();

		res.status(200).send(patterns);
	} catch (e) {
		res.status(500).send("Could not fetch product patterns");
	}
});

router.get("/v1/product-pages", async (req, res) => {
	try {
		verbose(`Querying product pages`);

		const pages = await depotApi.productPages();

		res.status(200).send(pages);
	} catch (e) {
		res.status(500).send("Could not fetch product pages");
	}
});

router.get("/v1/product-cover", async (req, res) => {
	try {
		verbose(`Querying product covers`);

		const covers = await depotApi.productCover();

		res.status(200).send(covers);
	} catch (e) {
		res.status(500).send("Could not fetch product covers");
	}
});
