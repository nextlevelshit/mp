import express from "express";
import {version} from "../package.json";
import {depotApi} from "./services/DepotApi";
import {adyenApi} from "./services/AdyenApi";
import debug from "debug";
import {OrderDto} from "./dto/OrderDto";
import {adyenClientKey} from "./config/constants";

const logger = debug("mp:i:shop-api:router");
const verbose = debug("mp:v:shop-api:router");


export const router = express.Router();

router.get("/v1", async (req, res) => {
	const today = new Date().toISOString().split("T")[0];

	res.send(`<h1>mp-shop-api v${version} - ${today}</h1>`);
});

router.post("/v1/order/", async (req, res) => {
	try {
		const cart = await depotApi.orderFactory().create();

		res.status(201).send(cart.attributes.uuid);
	} catch (e) {
		res.status(500).send("Could not create cart");
	}
});

router.all("/v1/order/:uuid", async (req, res) => {
	if (!req.params.uuid) res.status(422).send("Missing cart UUID");

	try {
		const {uuid} = req.params;

		switch (req.method) {
			case "GET":
				verbose(`Querying order with UUID ${uuid}`);

				const fetchedOrder = new OrderDto(await depotApi.orderFactory().one(uuid));

				res.status(200).send(fetchedOrder.dto);
				break;
			case "PUT":
				verbose(`Updating order with UUID ${uuid}`);

				if (!req.body) res.status(422).send("Missing data to be updated");

				const updatedOrder = new OrderDto(await depotApi.orderFactory().update(uuid, req.body));

				res.status(200).send(updatedOrder.dto);
				break;
			default:
				res.status(405).send("Method not allowed");
		}
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not fetch or update order");
	}
});

router.put("/v1/order/:uuid/add-product/:productId", async (req, res) => {
	if (!req.params.uuid) res.send(422).send("Missing order UUID");
	if (!req.params.productId) res.send(422).send("Missing product ID");

	const {uuid, productId} = req.params;
	const countParam = req.query.count;
	const count = countParam ? parseInt(countParam as string) || 1 : 1;

	try {
		const updatedOrder = new OrderDto(await depotApi.orderFactory().addProduct(uuid, productId, count));

		res.status(200).send(updatedOrder.dto);
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not add product to order");
	}
});

router.put("/v1/order/:uuid/remove-product/:productId", async (req, res) => {
	if (!req.params.uuid) res.send(422).send("Missing order UUID");
	if (!req.params.productId) res.send(422).send("Missing product ID");

	const {uuid, productId} = req.params;
	const countParam = req.query.count;
	const count = countParam ? parseInt(countParam as string) || 1 : 1;

	try {
		const updatedOrder = new OrderDto(await depotApi.orderFactory().removeProduct(uuid, productId, count));

		res.status(200).send(updatedOrder.dto);
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not add product to order");
	}
});


router.post("/v1/order/:uuid/checkout", async (req, res) => {
	if (!req.params.uuid) res.status(422).send("Missing order UUID");
	if (!req.query.returnUrl) res.status(422).send("Missing returnUrl");

	try {
		const returnUrl = req.query.returnUrl as string;
		const order = await depotApi.orderFactory().one(req.params.uuid);
		const orderDto = new OrderDto(order);
		const adyenSession = await adyenApi.createSessionOrThrow(returnUrl, orderDto);
		res.status(200).json({session: adyenSession, clientKey: adyenClientKey});
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not create checkout session");
	}
});

router.all("/v1/order/:uuid/redirect", async (req, res) => {
	if (!req.params.uuid) res.status(422).send("Missing order UUID");

	try {
		await depotApi.orderFactory().one(req.params.uuid);

		const resultPath = await adyenApi.handleShopperRedirect(req.method === "GET" ? req.query : req.body);
		res.redirect(resultPath);
	} catch (e) {
		res.redirect("/result/error");
	}
});

router.put("/v1/order/:uuid/generate-invoice", async (req, res) => {
	try {
		const { uuid } = req.params;

		const order = new OrderDto(await depotApi.orderFactory().generateInvoiceAndSaveToOrder(uuid));

		res.status(200).send(order.dto);
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not generate and save the invoice");
	}
});

router.put("/v1/order/:uuid/generate-delivery-note", async (req, res) => {
	try {
		const { uuid } = req.params;

		const order = new OrderDto(await depotApi.orderFactory().generateDeliveryNoteAndSaveToOrder(uuid));

		res.status(200).send(order.dto);
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not generate and save the delivery note");
	}
});

router.put("/v1/order/:uuid/send-invoice", async (req, res) => {
	try {
		const { uuid } = req.params;

		const order = new OrderDto(await depotApi.orderFactory().sendInvoiceAndUpdateOrder(uuid));

		res.status(200).send(order.dto);
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not send invoice via email, order has not been changed");
	}
});

router.get("/v1/product", async (req, res) => {
	try {
		verbose(`Querying products`);

		const productList = await depotApi.productFactory().all({
			pagination: {
				start: 0,
				limit: 200
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

