<template>
	<a
		:href="path"
		:title="ariaLabel"
		:aria-label="ariaLabel"
		:aria-checked="isActive"
		:class="{
			'border-black': isActive,
			'border-transparent cursor-pointer bg-gray-200 opacity-60 hover:opacity-100 pointer':
				!isActive
		}"
		class="flex flex-col items-center gap-y-4 rounded-md border-2 pt-2 pb-2 px-2"
	>
		<div v-if="$slots.default" class="w-12 h-12 bg-gray-500 overflow-hidden">
			<slot></slot>
		</div>
		<div class="text-sm text-gray-800">{{ label }}</div>
	</a>
</template>

<script lang="ts">
import debug from "debug";

const logger = debug("app:i:selection-box");
const verbose = debug("app:v:selection-box");

export default {
	props: ["label", "path", "isActive", "ariaLabel"]
};
</script>
