export default {
  routes: [
    {
     method: 'GET',
     path: '/product-category',
     handler: 'product-category.categories',
     config: {
       policies: [],
       middlewares: [],
     },
    },
  ],
};
