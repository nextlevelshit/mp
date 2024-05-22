import type { Schema, Attribute } from '@strapi/strapi';

export interface ProductsCart extends Schema.Component {
  collectionName: 'components_products_carts';
  info: {
    displayName: 'cart';
    icon: 'stack';
    description: '';
  };
  attributes: {
    product: Attribute.Relation<
      'products.cart',
      'oneToOne',
      'api::product.product'
    >;
    count: Attribute.Integer &
      Attribute.SetMinMax<
        {
          min: 1;
        },
        number
      > &
      Attribute.DefaultTo<1>;
  };
}

declare module '@strapi/types' {
  export module Shared {
    export interface Components {
      'products.cart': ProductsCart;
    }
  }
}
