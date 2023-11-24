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
	// Create cart
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
