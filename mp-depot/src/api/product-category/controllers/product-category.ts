/**
 * A set of functions called "actions" for `product-category`
 */

export default () => ({
	categories: async (ctx, next) => {
		try {
			ctx.body = await strapi
				.service("api::product-category.product-category")
				.categories();
		} catch (err) {
			ctx.badRequest("Product category controller error", { moreDetails: err });
		}
	}
});
