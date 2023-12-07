import {config} from "dotenv";
import express from "express";
import cors from "cors";
import {router} from "./router";
import {expressTrustProxy, port} from "./config/constants";
import debug from "debug";

const logger = debug("mp:i:shop-api:app");
const verbose = debug("mp:v:shop-api:app");

config();

const app = express();

app.disable("x-powered-by");
// https://expressjs.com/en/guide/behind-proxies.html
app.set("trust proxy", expressTrustProxy);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(router);

app.listen(port, () => {
	logger(
		`Listening on port ${port}`
	);
});

app.on("error", (err) => {
	logger(`HTTP server error: ${err}`);
});
