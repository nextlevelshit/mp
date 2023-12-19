import { config } from "dotenv";
import express from "express";
import cors from "cors";
import { router } from "./router";
import { expressTrustProxy, port } from "./config/constants";
import debug from "debug";
import { collectDefaultMetrics, register } from "prom-client"; // Import Prometheus-related modules

const logger = debug("mp:i:shop-api:app");
const verbose = debug("mp:v:shop-api:app");

config();

const app = express();

// Initialize Prometheus default metrics collection
collectDefaultMetrics();

app.disable("x-powered-by");
app.set("trust proxy", expressTrustProxy);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(router);

app.get("/metrics", async (req, res) => {
	// Expose Prometheus metrics endpoint
	try {
		const metrics = await register.metrics();
		res.set("Content-Type", register.contentType);
		res.end(metrics);
	} catch (error) {
		console.error("Error generating metrics:", error);
		res.status(500).send("Internal Server Error");
	}
});

app.listen(port, () => {
	logger(`Listening on port ${port}`);
});

app.on("error", (err) => {
	logger(`HTTP server error: ${err}`);
});
