<template>
	<header class="text-white bg-gray-900 pb-8 mb-2">
		<div class="container mx-auto">
			<h1 class="py-6 font-semibold">mp-konsole v{{version}}</h1>
			<nav class="flex gap-4">
				<router-link class="hover:text-gray-300" to="/"
					>Rechnung erstellen</router-link
				>
				<router-link class="hover:text-gray-300" to="/list/customers"
					>Kundenadressen</router-link
				>
				<router-link class="hover:text-gray-300" to="/list/invoices"
					>Rechnungen</router-link
				>
				<router-link class="hover:text-gray-300" to="/list/orders"
					>Bestellungen</router-link
				>
				<router-link class="hover:text-gray-300" to="/list/products"
					>Produkte</router-link
				>
			</nav>
		</div>
	</header>
	<main class="pt-4">
		<router-view :key="$route.path"></router-view>
	</main>
</template>
<script>

import { version } from "../package.json";

export default {
  data() {
    return {
      version: version ?? "1.0.0"
    }
  }
}
</script>
