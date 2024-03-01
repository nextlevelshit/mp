<template>
	<main class="pt-4 container mx-auto">
		<div v-if="markdown">
			<vue-markdown :source="markdown" />
		</div>
	</main>
</template>

<script lang="ts">
import {defineComponent, type PropType} from "vue";
import Title from "@/components/Title.vue";
import {shopApi} from "@/services/ShopApi";
import debug from "debug";

const logger = debug("app:i:legal-view");
const verbose = debug("app:v:legal-view");

export default defineComponent({
	data() {
		return {
			markdown: "",
		}
	},
	components: {Title},
	props: {
		content: {
			type: String as PropType<"legal" | "contact" | "terms" | "privacyPolicy">,
			required: true,
		}
	},
	mounted: async function () {
	    try {
			const data = await shopApi.getLegal();
			this.markdown = data[this.content];
		} catch (e) {
			verbose("Error fetching imprint", e);
		}
	},
})
</script>

<style scoped>
h1 {
	@apply text-3xl;
}
</style>
