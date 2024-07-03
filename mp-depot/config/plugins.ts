export default ({ env }) => ({
	documentation: {
		enabled: true,
		config: {
			openapi: "3.0.1",
			info: {
				version: "1.0.0",
				title: "MUELLERPTINTS. Paperwork",
				description: "API Documentation for MUELLERPRINTS. Paperwork",
				termsOfService: false,
				contact: {
					name: "Michael W. Czechowski",
					email: "mail@dailysh.it",
					url: "https://dailysh.it"
				},
				license: "Copyright (C) 2024 Michael W. Czechowski",
				externalDocs: false
			},
			"x-strapi-config": {
				plugins: ["upload"],
				path: "/documentation",
				mutateDocumentation: (draft: any) => {
					draft.paths["/order/{uuid}"].get.parameters[0].schema.type = "string";
					draft.paths["/order/{uuid}"].put.parameters[0].schema.type = "string";
					draft.paths["/order/{uuid}/generate-delivery-note"].put.parameters[0].schema.type = "string";
					draft.paths["/order/{uuid}/generate-invoice"].put.parameters[0].schema.type = "string";
					draft.paths["/order/{uuid}/add-product/{productId}"].put.parameters[0].schema.type = "string";
					draft.paths["/order/{uuid}/remove-product/{productId}"].put.parameters[0].schema.type = "string";
					draft.paths["/order/{uuid}/checkout"].post.parameters[0].schema.type = "string";
					draft.paths["/order/{uuid}/checkout/redirect"].get.parameters[0].schema.type = "string";
					draft.paths["/order/{uuid}/send-invoice"].put.parameters[0].schema.type = "string";
					draft.paths["/order/{uuid}/finalize"].put.parameters[0].schema.type = "string";

					delete draft.paths["/order"].post.requestBody;
					delete draft.paths["/order/{uuid}"].put.requestBody;
					delete draft.paths["/order/{uuid}/generate-delivery-note"].put.requestBody;
					delete draft.paths["/order/{uuid}/generate-invoice"].put.requestBody;
					delete draft.paths["/order/{uuid}/add-product/{productId}"].put.requestBody;
					delete draft.paths["/order/{uuid}/remove-product/{productId}"].put.requestBody;
					delete draft.paths["/order/{uuid}/checkout"].post.requestBody;
					delete draft.paths["/order/{uuid}/send-invoice"].put.requestBody;
					delete draft.paths["/order/{uuid}/finalize"].put.requestBody;

					draft.components.schemas["NotificationRequest"] = {
						type: "object",
						required: ["live", "notificationItems"],
						properties: {
							live: {
								type: "boolean",
								description: "Indicates whether this is a live notification or a test notification"
							},
							notificationItems: {
								type: "array",
								items: {
									$ref: "#/components/schemas/NotificationItem"
								},
								description: "An array of notification items"
							}
						}
					};

					draft.components.schemas["NotificationItem"] = {
						type: "object",
						required: ["NotificationRequestItem"],
						properties: {
							NotificationRequestItem: {
								$ref: "#/components/schemas/NotificationRequestItem"
							}
						}
					};

					draft.components.schemas["NotificationRequestItem"] = {
						type: "object",
						required: ["amount", "pspReference", "eventCode", "eventDate", "merchantAccountCode", "merchantReference", "success"],
						properties: {
							additionalData: {
								type: "object",
								additionalProperties: {
									type: "string"
								},
								description: "Additional data related to the notification"
							},
							amount: {
								$ref: "#/components/schemas/Amount"
							},
							pspReference: {
								type: "string",
								description: "Adyen's 16-character unique reference associated with the transaction/the request"
							},
							eventCode: {
								type: "string",
								enum: [
									"AUTHORISATION",
									"AUTHORISATION_ADJUSTMENT",
									"CANCELLATION",
									"CANCEL_OR_REFUND",
									"CAPTURE",
									"CAPTURE_FAILED",
									"DONATION",
									"HANDLED_EXTERNALLY",
									"ORDER_OPENED",
									"ORDER_CLOSED",
									"PENDING",
									"PROCESS_RETRY",
									"REFUND",
									"REFUND_FAILED",
									"REFUNDED_REVERSED",
									"REFUND_WITH_DATA",
									"REPORT_AVAILABLE",
									"VOID_PENDING_REFUND",
									"CHARGEBACK",
									"CHARGEBACK_REVERSED",
									"NOTIFICATION_OF_CHARGEBACK",
									"NOTIFICATION_OF_FRAUD",
									"PREARBITRATION_LOST",
									"PREARBITRATION_WON",
									"REQUEST_FOR_INFORMATION",
									"SECOND_CHARGEBACK",
									"PAYOUT_EXPIRE",
									"PAYOUT_DECLINE",
									"PAYOUT_THIRDPARTY",
									"PAIDOUT_REVERSED",
									"AUTORESCUE",
									"CANCEL_AUTORESCUE",
									"RECURRING_CONTRACT",
									"POSTPONED_REFUND",
									"OFFER_CLOSED",
									"MANUAL_REVIEW_ACCEPT",
									"MANUAL_REVIEW_REJECT",
									"EXPIRE"
								],
								description: "The type of event the notification item refers to"
							},
							eventDate: {
								type: "string",
								format: "date-time",
								description: "The time when the event was generated"
							},
							merchantAccountCode: {
								type: "string",
								description: "The merchant account identifier used in the transaction"
							},
							operations: {
								type: "array",
								items: {
									type: "string",
									enum: ["CANCEL", "CAPTURE", "REFUND"]
								},
								description: "List of the modification operations supported by the transaction"
							},
							merchantReference: {
								type: "string",
								description: "A reference to uniquely identify the payment"
							},
							originalReference: {
								type: "string",
								description: "The reference of the original payment (for modifications)"
							},
							paymentMethod: {
								type: "string",
								description: "The payment method used in the transaction"
							},
							reason: {
								type: "string",
								description: "Additional information about the event"
							},
							success: {
								type: "string",
								enum: ["true", "false"],
								description: "Indicates whether the event was executed successfully"
							}
						}
					};

					draft.components.schemas["Amount"] = {
						type: "object",
						required: ["currency", "value"],
						properties: {
							currency: {
								type: "string",
								description: "The three-character ISO currency code"
							},
							value: {
								type: "integer",
								description: "The amount in minor units (e.g., cents)"
							}
						}
					};

					draft.components.schemas["WebhookResponse"] = {
						type: "object",
						required: [],
						properties: {
							message: {
								type: "string",
								description: "Success message"
							}
						}
					};

					draft.paths["/order/webhook"].post.requestBody = {
						required: true,
						content: {
							"application/json": {
								schema: {
									$ref: "#/components/schemas/NotificationRequest"
								}
							}
						}
					};

					draft.paths["/order/webhook"].post.responses["200"].content["application/json"].schema["$ref"] =
						"#/components/schemas/WebhookResponse";
				}
			},
			servers: [
				{
					url: "/api",
					description: "Docker Container"
				},
				{
					url: "http://localhost:5555/api",
					description: "Local Development"
				}
			],
			security: [
				{
					bearerAuth: []
				}
			]
		}
	},
	"strapi-prometheus": {
		enabled: true,
		config: {
			// add prefix to all the prometheus metrics names.
			prefix: "mp_depot",

			// use full url instead of matched url
			// true  => path label: `/api/models/1`
			// false => path label: `/api/models/:id`
			fullURL: false,

			// include url query in the url label
			// true  => path label: `/api/models?limit=1`
			// false => path label: `/api/models`
			includeQuery: false,

			// metrics that will be enabled, by default they are all enabled.
			enabledMetrics: {
				koa: true, // koa metrics
				process: true, // metrics regarding the running process
				http: true, // http metrics like response time and size
				apollo: true // metrics regarding graphql
			},

			// interval at which rate metrics are collected in ms
			interval: 30_000,

			// set custom/default labels to all the prometheus metrics
			customLabels: {
				name: "strapi-prometheus"
			}
		}
	}
});
