<template>
  <Stepper :step="3" />

	<div v-if="cart">
    <h2 class="text-xl mb-4">Checkout - Step 3</h2>

    <div class="flex gap-6">
      <div class="payment w-2/3" ref="payment"></div>
      <div class="w-1/3">
        <h3 class="text-lg font-semibold mb-2">Cart Summary</h3>
        <p>Total: {{ cart.total?.toFixed(2) }} €</p>
        <p>Subtotal: {{ cart.subtotal?.toFixed(2) }} €</p>
        <p>VAT: {{ cart.VAT?.toFixed(2) }} €</p>

        <h3 class="text-lg font-semibold mb-2 mt-4">Products</h3>
        <ul>
          <li v-for="(cartProduct, index) in cart.cartProducts" :key="index">
            {{ cartProduct.product.name }} ({{ cartProduct.count }} items) - {{ cartProduct.product.totalProductPrice.toFixed(2) }} €
          </li>
        </ul>

        <h3 class="text-lg font-semibold mb-2 mt-4">Customer Information</h3>
        <p>Email: {{ cart.email }}</p>
        <p>Address: {{ cart.address }}</p>

        <div class="bg-gray-100 mt-10 p-8 text-xs text-gray-700">
          <p>Mit dem Kauf akzeptiere ich die AGB und Nutzungsbedingungen.</p>
          <p class="text-sm mt-4">
            Sicherheitsabfrage bei Kreditkartenzahlung
          </p>
          <p class="mt-4">Möglicherweise werden Sie im nächsten Schritt von Ihrer Bank gebeten, Ihre Kreditkarte zu verifizieren (3-D Secure).</p>
          <p class="text-sm mt-4">Hinweise zum Datenschutz</p>
          <p class="mt-2">Die personenbezogenen Daten werden für die Abwicklung der Bestellung automatisiert verarbeitet. Der Schutz Ihrer persönlichen Daten ist uns wichtig. Daher verwenden wir bei der Übertragung moderne Verschlüsselungstechnologien. Weiteres entnehmen Sie bitte unseren Datenschutzhinweisen.</p>
        </div>
      </div>
    </div>
  </div>
  <div v-else>
    Loading cart ...
  </div>
  <CodeBlock>{{ cart }}</CodeBlock>
</template>

<script lang="ts">
import debug from "debug";
import AdyenCheckout from "@adyen/adyen-web";
import "@adyen/adyen-web/dist/adyen.css";
import CodeBlock from "@/components/CodeBlock.vue";
import {shopApi} from "@/services/ShopApi";
import {localStorageLabelCartUuid} from "@/config/constants";
import type {Order} from "@/types";
import {cart} from "@/stores/cart";
import Stepper from "@/components/Stepper.vue";

const logger = debug("app:i:checkout-view");
const verbose = debug("app:v:checkout-view");

export default {
  components: {Stepper, CodeBlock},
  computed: {
    uuid() {
      return cart.uuid
    }
  },
	data() {
		return {
      cart: {} as Order | null,
      address: "Hans Wurst\nStraße 123\n012345 Stadt",
      deliveryAddress: "",
		}
	},
	async mounted() {
		const urlParams = new URLSearchParams(window.location.search);
		const sessionId = urlParams.get("sessionId");
		const redirectResult = urlParams.get("redirectResult");

    try {
      this.cart = await shopApi.getOrder(this.uuid);

      if (!this.cart) {
        verbose("Could not fetch cart with ID:", this.uuid);
        return;
      }

      if (sessionId) {
        await this.finalizeCheckout(sessionId, redirectResult!);
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
		async finalizeCheckout(id: string, details: string) {
			verbose("SessionId found, finilizing checkout");
      const checkout = await this.createAdyenCheckout({id});
      checkout.submitDetails({details});
		},
    async createAdyenCheckout(session: any, clientKey?: string): Promise<any> {
      if (!this.cart) {
        logger("Cart not found, cannot create checkout");
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
          logger("Checkout failed");
          verbose(error.name, error.message, error.stack, component);
        }
      };
      return AdyenCheckout(configuration);
    },
    async handleCheckoutResponse(res: any, component: any) {
      verbose("Handling checkout response:", res);
      if (!this.cart) {
        logger("Cart not found, cannot proceed");
        return;
      }

      const {uuid} = this.cart;

      if (res.action) {
        component.handleAction(res.action);
      } else {
        switch (res.resultCode) {
          case "Authorised":
            await shopApi.finalizeOrder(uuid);
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
