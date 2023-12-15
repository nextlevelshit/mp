<template>
	<div v-if="cart">
    Checkout for {{cart.uuid}}
    <div class="payment" ref="payment"></div>
    <CodeBlock>{{ cart }}</CodeBlock>
  </div>
  <div v-else>
    Loading cart ...
  </div>
</template>

<script lang="ts">
import debug from "debug";
import AdyenCheckout from "@adyen/adyen-web";
import "@adyen/adyen-web/dist/adyen.css";
import CodeBlock from "@/components/CodeBlock.vue";
import {shopApi} from "@/services/ShopApi";
import {localStorageLabelCartUuid} from "@/config/constants";
import type {Order} from "@/types";

const logger = debug("app:i:checkout-view");
const verbose = debug("app:v:checkout-view");

export default {
  components: {CodeBlock},
	data(): {
    cart: Order | null,
    sessionId: string | null,
    redirectResult: any | null
  } {
		return {
      cart: null,
      sessionId: "",
			redirectResult: ""
		}
	},
	async mounted() {
		const urlParams = new URLSearchParams(window.location.search);
		this.sessionId = urlParams.get("sessionId");
		this.redirectResult = urlParams.get("redirectResult");

    try {
      const uuid = localStorage.getItem(localStorageLabelCartUuid);

      this.cart = await shopApi.getOrCreateOrder(uuid);

      if (!this.cart) {
        verbose("Could not fetch cart with ID:", uuid);
        return;
      }

      localStorage.setItem(localStorageLabelCartUuid, this.cart.uuid);

      if (this.sessionId) {
        await this.finalizeCheckout();
      } else {
        await this.startCheckout();
      }
    } catch (error) {
      verbose("Error fetching or creating cart:", error);
    }
	},
	methods: {
		async startCheckout() {
			verbose("SessionId not found, initilizing checkout");
      if (!this.cart) {
        verbose("Cart not found, cannot initilize checkout");
        return;
      }
      const {session, clientKey} = await shopApi.checkoutOrder(this.cart.uuid);
      const checkout = await this.createAdyenCheckout(session, clientKey);
      checkout.create("dropin").mount(this.$refs["payment"]);
		},
		async finalizeCheckout() {
			verbose("SessionId found, finilizing checkout");
      const checkout = await this.createAdyenCheckout({id: this.sessionId});
      checkout.submitDetails({details: this.redirectResult});
		},
    async createAdyenCheckout(session: any, clientKey?: string): Promise<any> {
      if (!this.cart) {
        verbose("Cart not found, cannot create checkout");
        return;
      }
      const configuration = {
        clientKey,
        session,
        analytics: {
          enabled: false
        },
        locale: "de_DE",
        environment: "test", // change to live for production
        showPayButton: true,
        paymentMethodsConfiguration: {
          card: {
            hasHolderName: true,
            holderNameRequired: true,
            name: "Kreditkarte oder Debitkarte",
            amount: {
              currency: session.amount.currency || "EUR",
              value: session.amount.value || Math.round(this.cart.total * 100)
            }
          },
          paypal: {
            amount: {
              currency: session.amount.currency || "EUR",
              value: session.amount.value || Math.round(this.cart.total * 100)
            },
            environment: "test",
            countryCode: "DE"   // Only needed for test. This will be automatically retrieved when you are in production.
          }
        },
        onPaymentCompleted: async (result: any, component: any) => {
          await this.handleCheckoutResponse(result, component);
        },
        onError: (error: any, component: any) => {
          verbose(error.name, error.message, error.stack, component);
        }
      };
      return AdyenCheckout(configuration);
    },
    async handleCheckoutResponse(res: any, component: any) {
      verbose("Handling checkout response:", res);
      if (!this.cart) {
        verbose("Cart not found, cannot proceed");
        return;
      }

      const {uuid} = this.cart;

      if (res.action) {
        component.handleAction(res.action);
      } else {
        switch (res.resultCode) {
          case "Authorised":
            await shopApi.updateOrder(uuid, {
              paymentAuthorised: true,
              paymentStatus: "authorised",
              Date: new Date().toISOString().slice(0, 10)
            });
            await shopApi.generateInvoice(uuid);
            await shopApi.generateDeliveryNote(uuid);
            await shopApi.sendInvoice(uuid);
            break;
          case "Pending":
          case "Received":
            await shopApi.updateOrder(uuid, {
              paymentStatus: "pending"
            });
            verbose("Order pending");
            break;
          case "Refused":
            await shopApi.updateOrder(uuid, {
              paymentStatus: "refused"
            });
            verbose("Order refused");
            break;
          default:
            await shopApi.updateOrder(uuid, {
              paymentStatus: "error"
            });
            break;
        }

        window.location.assign(`/checkout/result/${uuid}`);
      }
    }
	}
}
</script>
