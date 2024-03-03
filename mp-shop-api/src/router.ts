import express from "express";
import {Counter, Histogram} from "prom-client";
import {version} from "../package.json";
import {depotApi} from "./services/DepotApi";
import {adyenApi} from "./services/AdyenApi";
import debug from "debug";
import {OrderDto} from "./dto/OrderDto";
import {adyenClientKey} from "./config/constants";

const logger = debug("app:i:shop-api:router");
const verbose = debug("app:v:shop-api:router");

const orderCounter = new Counter({
	name: "mp_shop_api_order_created_total",
	help: "Total number of orders created",
});

const finalizedOrderCounter = new Counter({
	name: "mp_shop_api_order_finalized_total",
	help: "Total number of orders finalized",
});

const requestDurationHistogram = new Histogram({
	name: "mp_shop_api_request_duration_seconds",
	help: "Histogram of request durations in seconds",
	labelNames: ["path", "method", "status"],
	buckets: [0.1, 0.5, 1, 2, 5], // Specify appropriate buckets based on your expected request duration
});

const requestTotalCounter = new Counter({
	name: "mp_shop_api_request_total",
	help: "Total number of requests",
	labelNames: ["path", "method", "status"],
});

const healthCheckCounter = new Counter({
	name: "mp_shop_api_health_check_total",
	help: "Total number of health checks",
});

export const router = express.Router();

// Middleware for tracking request duration
router.use((req, res, next) => {
	const start = Date.now();
	res.on("finish", () => {
		const duration = (Date.now() - start) / 1000; // Convert to seconds
		requestDurationHistogram.labels(req.route?.path, req.method, res.statusCode.toString()).observe(duration);
		requestTotalCounter.labels(req.route?.path, req.method, res.statusCode.toString()).inc();
	});
	next();
});

router.get("/v1", async (req, res) => {
	const today = new Date().toISOString().split("T")[0];

	res.send(`<h1>mp-shop-api v${version} - ${today}</h1>`);
});

router.post("/v1/order/", async (req, res) => {
	try {
		const cart = await depotApi.orderFactory().create();

		orderCounter.inc();

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

				let fetchedOrder = new OrderDto(await depotApi.orderFactory().one(uuid));

				res.status(200).send(fetchedOrder.dto);
				break;
			case "PUT":
				verbose(`Updating order with UUID ${uuid}`);

				if (!req.body) res.status(422).send("Missing data to be updated");

				let updatedOrder = new OrderDto(await depotApi.orderFactory().update(uuid, req.body));

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
		const adyenSession = await adyenApi.createSessionOrThrow(returnUrl, new OrderDto(order));
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
		const {uuid} = req.params;

		const order = await depotApi.orderFactory().generateInvoiceAndSaveToOrder(uuid);

		res.status(200).send(new OrderDto(order).dto);
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not generate and save the invoice");
	}
});

router.put("/v1/order/:uuid/generate-delivery-note", async (req, res) => {
	try {
		const {uuid} = req.params;

		const order = await depotApi.orderFactory().generateDeliveryNoteAndSaveToOrder(uuid);

		res.status(200).send(new OrderDto(order).dto);
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not generate and save the delivery note");
	}
});

router.put("/v1/order/:uuid/send-invoice", async (req, res) => {
	try {
		const {uuid} = req.params;

		const order = await depotApi.orderFactory().sendInvoiceAndUpdateOrder(uuid);

		res.status(200).send(new OrderDto(order).dto);
	} catch (e) {
		verbose(e);
		res.status(500).send("Could not send invoice via email, order has not been changed");
	}
});

router.put("/v1/order/:uuid/finalize", async (req, res) => {
	try {
		const {uuid} = req.params;

		const authorisedOrder = await depotApi.orderFactory().update(uuid, {
			paymentAuthorised: true,
			paymentStatus: "authorised",
			Date: new Date().toISOString().slice(0, 10),
		});

		res.status(200).send(new OrderDto(authorisedOrder).dto);

		verbose(`Finalizing order with UUID ${uuid}`);

		await Promise.all([
			depotApi.orderFactory().generateInvoiceAndSaveToOrder(uuid),
			depotApi.orderFactory().generateDeliveryNoteAndSaveToOrder(uuid),
		]);

		verbose(`Sending invoice and delivery note for order with UUID ${uuid}`);

		await depotApi.orderFactory().sendInvoiceAndUpdateOrder(uuid);

		verbose(`Order with UUID ${uuid} has been finalized`);

		finalizedOrderCounter.inc();

	} catch (e) {
		verbose(e);
		res.status(500).send("Could not finalize order");
	}
});

router.get("/v1/product", async (req, res) => {
	try {
		verbose(`Querying products`);

		const [allCovers, allRulings, allPages] = await Promise.all([
			depotApi.productCover(),
			depotApi.productRuling(),
			depotApi.productPages()
		]);

		const lowestPriceCover = allCovers.sort((a, b) => a.price - b.price)[0].id;
		const lowestPriceRuling = allRulings.sort((a, b) => a.price - b.price)[0].id;
		const lowestPricePages = allPages.sort((a, b) => a.price - b.price)[0].id;

		logger({
			lowestPriceCover,
			lowestPriceRuling,
			lowestPricePages
		});

		const cover = req.query.cover ? parseInt(req.query.cover as string) : lowestPriceCover;

		const productList = await depotApi.productFactory().all({
			pagination: {
				start: 0,
				limit: 200
			},
			filters: {
				ruling: {
					id: {
						$eq: lowestPriceRuling
					}
				},
				pages: {
					id: {
						$eq: lowestPricePages
					}
				},
				cover: {
					id: {
						$eq: cover
					}
				}
			}
		});

		res.status(200).send(productList);
	} catch (e) {
		res.status(500).send("Could not fetch products");
	}
});

router.get("/v1/product/:id", async (req, res) => {
	try {
		const {id} = req.params;
		verbose(`Querying product with ID ${id}`);

		const product = await depotApi.productFactory().one(id);

		res.status(200).send(product);
	} catch (e) {
		res.status(500).send("Could not fetch product");
	}
});

router.get("/v1/product/:id/variants/all", async (req, res) => {
	try {
		const {id} = req.params;
		verbose(`Querying variants of product with ID ${id}`);

		const variants = await depotApi.productFactory().allVariants(id);

		res.status(200).send(variants);
	} catch (e) {
		res.status(500).send("Could not fetch product");
	}
});

router.get("/v1/product/:id/variants/pattern", async (req, res) => {
	try {
		const {id} = req.params;
		verbose(`Querying variants of product with ID ${id}`);

		const variants = await depotApi.productFactory().variantsByPattern(id);

		res.status(200).send(variants);
	} catch (e) {
		res.status(500).send("Could not fetch product");
	}
});

router.get("/v1/product/:id/variants", async (req, res) => {
	try {
		const {id} = req.params;
		verbose(`Querying variants of product with ID ${id}`);

		const variants = await depotApi.productFactory().variants(id);

		res.status(200).send(variants);
	} catch (e) {
		res.status(500).send("Could not fetch product variants");
	}
});

router.get("/v1/legal", async (req, res) => {
	try {
		verbose(`Querying legal pages`);

		const legalPages = await depotApi.legal();

		res.status(200).send(legalPages);
	} catch (e) {
		res.status(500).send("Could not fetch product rulings");
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

		const patterns = await depotApi.productPattern({
			pagination: {
				limit: 100
			}
		});

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

		const covers = await depotApi.productCover({
			fields: ["id", "name", "binding", "price"],
			populate: {icon: {fields: ["url"]}}
		});

		res.status(200).send(covers);
	} catch (e) {
		res.status(500).send("Could not fetch product covers");
	}
});

router.post("/v1/webhooks/notifications", async (req, res) => {
	const webhookResponse = await adyenApi.handleWebhook(req.body);
	res.status(webhookResponse.statusCode).send(webhookResponse.message);
});

router.get("/health", async (req, res) => {
	healthCheckCounter.inc();
	res.status(200).json({status: "ok"});
});
