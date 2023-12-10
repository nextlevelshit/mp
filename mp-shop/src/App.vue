<template>
	<header class="text-white bg-stone-800 pb-8 mb-2">
		<div class="container mx-auto">
			<h1 class="py-6 font-semibold">mp-shop</h1>
			<nav class="flex gap-4">
				<router-link class="hover:text-gray-300" to="/products">
					Produkte
				</router-link>
				<router-link class="hover:text-gray-300" to="/cart">
					Warenkorb
				</router-link>
			</nav>
		</div>
	</header>
	<main class="pt-4 container mx-auto">
		<router-view :key="$route.path"></router-view>
	</main>
</template>
<script>
export default {
};
</script>
