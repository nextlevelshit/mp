/**
 * A set of functions called "actions" for `product`
 */

export default () => ({
  create: async (ctx) => {
    const body = ctx.request.body;
    const newOrder = await strapi.service("api::product.product").create(body);
    return newOrder;
  },

  all: async (ctx) => {
    const products = await strapi.service("api::product.product").all();
    return products;
  },

  findOne: async (ctx) => {
    const {id} = ctx.params;
    const product = await strapi.service("api::product.product").findOne({id});
    return product;
  },

  update: async (ctx) => {
    const {id} = ctx.params;
    const body = ctx.request.body;
    const updatedOrder = await strapi.service("api::product.product").update({id}, body);
    return updatedOrder;
  },

  delete: async (ctx) => {
    const {id} = ctx.params;
    const deletedOrder = await strapi.service("api::product.product").delete({id});
    return deletedOrder;
  },

  allVariants: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  },

  variantsByPattern: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  },

  variants: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  }
});
