/**
 * A set of functions called "actions" for `product-category`
 */

import {factories} from '@strapi/strapi'
import {sanitize} from "@strapi/utils";
import {Result} from "@strapi/types/dist/modules/entity-service/result";
import {v4 as generateUuid} from "uuid";
import {adyenClientKey, vatDecimal} from "../../../../config/constants";
import {adyenApi} from "../../../services/AdyenApi";
import {PdfBody, Order} from "../../../../types";
import {calculateTotalProductPrice} from "../../product/services/product";

export default factories.createCoreController('api::order.order', ({strapi}) => ({
  // Create a new order
  create: async (ctx) => {
    const body = {data: {uuid: generateUuid()}};
    strapi.log.debug(JSON.stringify({body}));
    const order = await strapi.service("api::order.order").create(body);
    return await sanitize.contentAPI.output(order, strapi.getModel("api::order.order"));
  },

  // Get an order by uuid
  findOne: async (ctx) => {
    const {uuid} = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
    strapi.log.debug(JSON.stringify({uuid}));
    const orderUnsafe = await strapi.service("api::order.order").findOneByUuid(uuid) as Order;
    const order = await sanitize.contentAPI.output(orderUnsafe, strapi.getModel("api::order.order")) as Order;
    strapi.log.debug(JSON.stringify({orderUnsafe}, null, 2));
    const cartUnsafe = orderUnsafe.cart;
    strapi.log.debug(JSON.stringify({cartUnsafe}, null, 2));
    const cart = cartUnsafe.map((product) => {
      return {
        ...product,
        totalProductPrice: calculateTotalProductPrice(product.product)
      }
    });
    strapi.log.debug(JSON.stringify({cart}, null, 2));

    return {
      ...order,
      cart
    };
  },

  addProduct: async (ctx) => {
    const {
      uuid,
      productId,
    } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
    const order = await strapi.service("api::order.order").findOneByUuid(uuid) as Order;
    const countParam = ctx.query.count;
    const count = countParam ? parseInt(countParam as string) || 1 : 1;
    const product = parseInt(productId as string);
    strapi.log.debug(JSON.stringify({uuid, product, count}));

    const currentCartProducts = order.cart || [];
    const updatedCartProducts = currentCartProducts.map(cartProduct => {
      if (cartProduct.product.id === product) {
        // Product is already in the cart, increment the count
        return {
          count: cartProduct.count + count,
          product: cartProduct.product.id,
        };
      }
      return {
        count: cartProduct.count,
        product: cartProduct.product.id
      };
    });
    // If product not found in currentCartProducts, add it to updatedCartProducts
    const isProductAlreadyInCart = updatedCartProducts.find(cartProduct => cartProduct.product === product);
    if (!isProductAlreadyInCart) {
      updatedCartProducts.push({
        count,
        product,
      });
    }
    strapi.log.debug(JSON.stringify({updatedCartProducts}));
    const body = {
      data: {
        cart: updatedCartProducts
      },
    };

    const orderUnsafe = await strapi.service("api::order.order").update(order.id, body);
    return await sanitize.contentAPI.output(orderUnsafe, strapi.getModel("api::order.order"))
  },

  removeProduct: async (ctx) => {
    const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
    strapi.log.debug(JSON.stringify({uuid}));
    return await strapi.service("api::order.order").removeProduct(uuid);
  },

  checkout: async (ctx) => {
    const { uuid, returnUrl } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
    strapi.log.debug(JSON.stringify({uuid, returnUrl}));
    const params = {
      filters: {
        uuid: {
          $eq: uuid
        }
      }
    };
    strapi.log.debug(JSON.stringify({params}));
    const response = await strapi.service("api::order.order").find(params);
    const results = await sanitize.contentAPI.output(response.results, strapi.getModel("api::order.order")) as Result<"api::order.order">[];
    strapi.log.debug(JSON.stringify({results}));
    if (results) {
      const order = results.pop();
      const adyenSession = await adyenApi.createSessionOrThrow(returnUrl as string, order);
      return {session: adyenSession, clientKey: adyenClientKey};
    } else {
      return ctx.badRequest("Could not checkout order");
    }
  },

  redirect: async (ctx) => {
    const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
    strapi.log.debug(JSON.stringify({uuid}));
    return await strapi.service("api::order.order").redirect(uuid);
  },

  generateInvoice: async (ctx) => {
    const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
    strapi.log.debug(JSON.stringify({uuid}));
    return await strapi.service("api::order.order").generateInvoice(uuid);
  },

  generateDeliveryNote: async (ctx) => {
    const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
    strapi.log.info(`order-controller: generating delivery note for ${uuid}`);
    strapi.log.debug(JSON.stringify({ctx}));
    return await strapi.service("api::order.order").generateDeliveryNote();
  },

  sendInvoice: async (ctx) => {
    const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
    strapi.log.info(`order-controller: sending invoice for ${uuid}`);
    strapi.log.debug(JSON.stringify({ctx}));
    return await strapi.service("api::order.order").sendInvoice();
  },

  finalize: async (ctx) => {
    const { uuid } = await sanitize.contentAPI.query(ctx.params, strapi.getModel("api::order.order"));
    strapi.log.info(`order-api: finalizing order ${uuid}`);
    strapi.log.debug(JSON.stringify({ctx}));
    return await strapi.service("api::order.order").finalize();
  }
}));

const invoicePdfBody = (order: Order): PdfBody => {
  const {id, invoiceAddress, cart, Date, email, address, VAT, subtotal, total, uuid} = order;

  return {
    subject: "RECHNUNG",
    date: Date.toLocaleString(),
    to: {
      name: "",
      address: invoiceAddress ? invoiceAddress.split("\n") : [],
    },
    nr: {
      customer: `${id}`,
      order: uuid,
      invoice: "123",
    },
    service: cart.map((cartProduct) => ({
      description: cartProduct.product.name,
      price: {
        per_unit: calculateTotalProductPrice(cartProduct.product) || 0,
        total: (calculateTotalProductPrice(cartProduct.product) || 0) * cartProduct.count,
      },
      count: cartProduct.count,
      nr: `${cartProduct.id}`,
    })) || [],
    currency: "\\euro",
    body: "Thank you for your purchase!",
    total,
    subtotal,
    VAT: {
      amount: VAT,
      rate: vatDecimal * 100
    }
  };
}

const deliveryNotePdfBody = (order: Order): PdfBody => {
  const {id, cart, Date, email, address, VAT, subtotal, total, uuid} = order;

  return {
    subject: "LIEFERSCHEIN",
    date: Date.toLocaleString(),
    to: {
      name: "",
      address: address ? address.split("\n") : []
    },
    nr: {
      customer: `${id}`,
      order: uuid,
      shipping: "123",
    },
    service: cart.map((cartProduct) => ({
      description: cartProduct.product.name,
      price: {
        per_unit: calculateTotalProductPrice(cartProduct.product) || 0,
        total: (calculateTotalProductPrice(cartProduct.product) || 0) * cartProduct.count,
      },
      count: cartProduct.count,
      nr: `${cartProduct.id}`,
    })) || [],
    currency: "\\euro",
    body: "Thank you for your purchase!",
    total,
    subtotal,
    VAT: {
      amount: VAT,
      rate: vatDecimal * 100
    }
  };
}
