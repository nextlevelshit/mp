<template>
	<router-link
		:to="path"
		class="text-gray-700 underline-offset-1 hover:underline-offset-4 hover:transition-all hover:decoration-current underline decoration-transparent ease-in-out flex flex-col justify-center"
		active-class="!decoration-current !underline-offset-4">
		{{ label }}
	</router-link>
</template>

<script lang="ts">
export default {
	props: ["path", "label"]
}
</script>
