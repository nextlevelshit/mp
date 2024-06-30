export default {
  routes: [
    {
      method: 'POST',
      path: '/order',
      handler: 'order.create',
      config: {
        policies: [],
      },
    },
    {
      method: 'POST',
      path: '/order/webhook',
      handler: 'order.webhook',
      config: {
        policies: [],
      },
    },
    {
      method: 'GET',
      path: '/order/:uuid',
      handler: 'order.findOne',
      config: {
        policies: [],
      },
    },
    {
      method: 'PUT',
      path: '/order/:uuid',
      handler: 'order.update',
      config: {
        policies: [],
      },
    },
    {
      method: 'PUT',
      path: '/order/:uuid/add-product/:productId',
      handler: 'order.addProduct',
      config: {
        policies: [],
      },
    },
    {
      method: 'PUT',
      path: '/order/:uuid/remove-product/:productId',
      handler: 'order.removeProduct',
      config: {
        policies: [],
      },
    },
    {
      method: 'POST',
      path: '/order/:uuid/checkout',
      handler: 'order.checkout',
      config: {
        policies: [],
      },
    },
    {
      method: 'GET',
      path: '/order/:uuid/redirect',
      handler: 'order.redirect',
      config: {
        policies: [],
      },
    },
    {
      method: 'PUT',
      path: '/order/:uuid/generate-invoice',
      handler: 'order.generateInvoice',
      config: {
        policies: [],
      },
    },
    {
      method: 'PUT',
      path: '/order/:uuid/generate-delivery-note',
      handler: 'order.generateDeliveryNote',
      config: {
        policies: [],
      },
    },
    {
      method: 'PUT',
      path: '/order/:uuid/send-invoice',
      handler: 'order.sendInvoice',
      config: {
        policies: [],
      },
    },
    {
      method: 'PUT',
      path: '/order/:uuid/finalize',
      handler: 'order.finalize',
      config: {
        policies: [],
      },
    },
  ],
};
