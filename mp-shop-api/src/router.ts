import express from "express";
import {version} from "../package.json";
import {depotApi} from "./services/DepotApi";
import {adyenApi} from "./services/AdyenApi";
import debug from "debug";
import {OrderDto} from "./dto/OrderDto";

const logger = debug("mp:i:shop-api:router");
const verbose = debug("mp:v:shop-api:router");


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

				const fetchedOrder = new OrderDto(await depotApi.orderFactory().one(uuid));

				res.status(200).send(fetchedOrder.dto);
				break;
			case "PUT":
				verbose(`Updating cart with UUID ${uuid}`);

				if (!req.body) res.status(422).send("Missing data to be updated");

				verbose("Request body", req.body);

				const updatedOrder = new OrderDto(await depotApi.orderFactory().update(uuid, req.body));

				res.status(200).send(updatedOrder.dto);
				break;
			default:
				res.status(405).send("Method not allowed")
		}
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not fetch or update cart");
	}
});


router.post("/v1/cart/:uuid/checkout", async (req, res) => {
	if (!req.params.uuid) res.status(422).send("Missing cart UUID");

	try {
		const protocol = req.protocol;
		const host = req.get("host") || "localhost";
		const order = await depotApi.orderFactory().one(req.params.uuid);
		const orderDto = new OrderDto(order);
		const adyenSession = await adyenApi.createSessionOrThrow(protocol, host, orderDto);
		res.status(200).json(adyenSession);
	} catch (e) {
		res.status(500).send("Could not create checkout session");
	}
});

router.all("/v1/cart/:uuid/redirect", async (req, res) => {
	if (!req.params.uuid) res.status(422).send("Missing cart UUID");

	try {
		await depotApi.orderFactory().one(req.params.uuid);

		const resultPath = await adyenApi.handleShopperRedirect(req.method === "GET" ? req.query : req.body);
		res.redirect(resultPath);
	} catch (e) {
		res.redirect("/result/error");
	}
});

router.get("/v1/product", async (req, res) => {
	try {
		verbose(`Querying products`);

		const productList = await depotApi.productFactory().all({
			pagination: {
				start: 0,
				limit: 20
			},
			// filters: {
			// 	ruling: {
			// 		id: {
			// 			$eq: 3
			// 		}
			// 	},
			// 	cover: {
			// 		id: {
			// 			$eq: 1
			// 		}
			// 	}
			// }
		});

		res.status(200).send(productList);
	} catch (e) {
		res.status(500).send("Could not fetch products");
	}
});

router.get("/v1/product/:id", async (req, res) => {
	try {
		const {id} = req.params;
		verbose(`Querying product with ID ${req.get("id")}`);

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

router.post("/v1/webhooks/notifications", async (req, res) => {
	const webhookResponse = await adyenApi.handleWebhook(req.body);
	res.status(webhookResponse.statusCode).send(webhookResponse.message);
});
