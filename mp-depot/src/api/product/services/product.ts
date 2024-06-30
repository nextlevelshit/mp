/**
 * This service is responsible for handling the product logic.
 */

import {factories} from '@strapi/strapi';
import {Product} from "../../../../types";


export default factories.createCoreService('api::product.product', ({ strapi }) => ({
  find: async (paramsOverride: Record<string, any>)   => {
    const params = {
      ...productDefaultParams,
      pagination: {
        pageSize: 10
      },
      ...paramsOverride,
    };
    strapi.log.verbose("Querying products with merged params:");
    strapi.log.verbose(JSON.stringify({params}));

    const response = await strapi.entityService.findPage("api::product.product", params);
    const resultsUnsafe = response.results;
    const results = resultsUnsafe.map((product) => {
      return {
        ...product,
        totalProductPrice: calculateTotalProductPrice(product)
      }
    });

    return { ...response, results };
  },

  findOne: async (id: number) => {
    const product = await strapi.entityService.findOne<"api::product.product", ProductParams>("api::product.product", id, productDefaultParams);
    return {
      ...product,
      totalProductPrice: calculateTotalProductPrice(product)
    }
  }
}));

export const calculateTotalProductPrice = (product: Product): number => {
  return (product?.cover?.price ?? 0) + (product?.pages?.price ?? 0) + (product?.ruling?.price ?? 0);
}

export interface ProductParams {
  populate: {
    pattern: any;
    cover: any;
    ruling: any;
    pages: any;
    images: {
      populate: {
        images: any;
      }
    }
  }
}

export const productDefaultParams: ProductParams = {
  populate: {
    pattern: true,
    cover: true,
    ruling: true,
    pages: true,
    images: {
      populate: {
        images: {
          fields: ["formats", "url"]
        }
      }
    }
  }
};
