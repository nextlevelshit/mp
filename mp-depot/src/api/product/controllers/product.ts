/**
 * A set of functions called "actions" for `product`
 */

import { factories } from "@strapi/strapi";
import { sanitize } from "@strapi/utils";
import { Result } from "@strapi/types/dist/modules/entity-service/result";

export default factories.createCoreController("api::product.product", ({ strapi }) => ({
	findOne: async (ctx) => {
		const { id } = await sanitize.contentAPI.query(
			ctx.params,
			strapi.getModel("api::product.product")
		);
		const productUnsafe = await strapi.service("api::product.product").findOne(id);
		return (await sanitize.contentAPI.output(
			productUnsafe,
			strapi.getModel("api::product.product")
		)) as Result<"api::product.product">;
	},

	find: async (ctx) => {
		try {
			const [allRulings, allPages] = await Promise.all([
				strapi.service("api::product-ruling.product-ruling").find({
					fields: ["price", "name"]
				}),
				strapi.service("api::product-page.product-page").find({
					fields: ["price", "name"]
				})
			]);

			const lowestPriceRuling = allRulings.results.sort(
				(a, b) => a.price - b.price
			)[0].id;
			const lowestPricePages = allPages.results.sort((a, b) => a.price - b.price)[0]
				.id;

			strapi.log.verbose(JSON.stringify({ lowestPriceRuling }));
			strapi.log.verbose(JSON.stringify({ lowestPricePages }));

			const params = await sanitize.contentAPI.query(
				ctx.query,
				strapi.getModel("api::product.product")
			);
			const response = await strapi.service("api::product.product").find({
				...params,
				ruling: lowestPriceRuling,
				page: lowestPricePages
			});
			const { pagination } = response;
			const data = (await sanitize.contentAPI.output(
				response.results,
				strapi.getModel("api::product.product")
			)) as Result<"api::product.product">[];

			return { data, meta: { pagination } };
		} catch (error) {
			strapi.log.error(error);
			return ctx.badRequest("Could not fetch products");
		}
	},

	allVariants: async (ctx) => {
		strapi.log.verbose(JSON.stringify(ctx));
		return "Not implemented";
	},

	variantsByPattern: async (ctx) => {
		strapi.log.verbose(JSON.stringify(ctx));
		return "Not implemented";
	},

	variants: async (ctx) => {
		strapi.log.verbose(JSON.stringify(ctx));
		return "Not implemented";
	}
}));
