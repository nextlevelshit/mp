/**
 * A set of functions called "actions" for `product-category`
 */

export default () => ({
  // Create a new order
  create: async (ctx) => {
    const body = ctx.request.body;
    const newOrder = await strapi.service("api::order.order").create(body);
    return newOrder;
  },

  // Get an order by id
  findOne: async (ctx) => {
    const {id} = ctx.params;
    const order = await strapi.service("api::order.order").findOne({id});
    return order;
  },

  // Update an order by id
  update: async (ctx) => {
    const {id} = ctx.params;
    const body = ctx.request.body;
    const updatedOrder = await strapi.service("api::order.order").update({id}, body);
    return updatedOrder;
  },

  // Delete an order by id
  delete: async (ctx) => {
    const {id} = ctx.params;
    const deletedOrder = await strapi.service("api::order.order").delete({id});
    return deletedOrder;
  },

  addProduct: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  },

  removeProduct: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  },

  checkout: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  },

  redirect: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  },

  generateInvoice: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  },

  generateDeliveryNote: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  },

  sendInvoice: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  },

  finalize: async (ctx) => {
    console.log(ctx);
    return "Not implemented";
  }
});
