export default {
	routes: [
		{
			method: "POST",
			path: "/product",
			handler: "product.create",
			config: {
				policies: []
			}
		},
		{
			method: "GET",
			path: "/product",
			handler: "product.find",
			config: {
				policies: []
			}
		},
		{
			method: "PUT",
			path: "/product/:id",
			handler: "product.update",
			config: {
				policies: []
			}
		},
		{
			method: "GET",
			path: "/product/:id",
			handler: "product.findOne",
			config: {
				policies: []
			}
		},
		{
			method: "GET",
			path: "/product/:id/variants/all",
			handler: "product.allVariants",
			config: {
				policies: []
			}
		},
		{
			method: "GET",
			path: "/product/:id/variants/pattern",
			handler: "product.variantsByPattern",
			config: {
				policies: []
			}
		},
		{
			method: "GET",
			path: "/product/:id/variants",
			handler: "product.variants",
			config: {
				policies: []
			}
		}
	]
};
