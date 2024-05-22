/**
 * product-category service
 */

export default  () => ({
  categories: async () => {
    try {
      return await strapi.entityService.findMany("api::product-cover.product-cover", {
        fields: ["id", "name", "binding"]
      });
    } catch (error) {
      return error;
    }
  }
})
