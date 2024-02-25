<template>
	<button :type="type" :class="classes" @click="handleClick()"
			class="bg-black text-white py-4 shadow-md hover:shadow-sm rounded-lg uppercase font-thin tracking-wide px-10">
		<slot />
	</button>
</template>

<script lang="ts">
export default {
	props: ["type", "classes", "href"],
	methods: {
		handleClick() {
			if (this.href) {
				window.location.assign(this.href)
			}
		}
	}
}
</script>
