<template>
	<main class="pt-4 px-4 lg:container mx-auto markdown">
		<VueMarkdown :source="imprint"/>
	</main>
</template>

<script lang="ts">
import {defineComponent} from "vue";
import Title from "@/components/Title.vue";
import {shopApi} from "@/services/ShopApi";
import debug from "debug";
import VueMarkdown from "vue-markdown-render";

const logger = debug("app:i:imprint-view");
const verbose = debug("app:v:imprint-view");

export default defineComponent({
	components: {Title, VueMarkdown},
	data() {
		return {
			imprint: "",
		}
	},
	mounted: async function () {
		try {
			const attributes = await shopApi.getLegal();
			verbose(attributes);
			this.imprint = attributes.imprint!;
		} catch (e) {
			verbose("Error fetching imprint", e);
		}
	},
})
</script>

<style>
.markdown {
	h1 {
		@apply text-3xl font-bold mb-5 mt-6;
	}
	h2 {
		@apply text-2xl font-bold mb-4 mt-5;
	}
	h3 {
		@apply text-xl mt-2 font-semibold mb-1;
	}
	ul {
		@apply list-disc pl-6;
	}
	p + p {
		@apply mt-4;
	}
	a {
		@apply underline-offset-2 underline hover:text-gray-700;
	}
}
</style>
