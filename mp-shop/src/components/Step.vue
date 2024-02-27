<template>
	<li :class="{ 'text-black': active, 'cursor-pointer hover:text-black group': url }" class="flex">
		<button class="flex items-center" @click="navigate(url)">
			<span v-if="isFinished" class="flex items-center justify-center w-5 h-5 me-2 text-xs border rounded-full shrink-0"
				  :class="{ 'border-black': active, 'border-gray-400': !active }">
			  {{ number }}
			</span>
			<svg v-else class="w-5 h-5 me-2" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
				<path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 8.207-4 4a1 1 0 0 1-1.414 0l-2-2a1 1 0 0 1 1.414-1.414L9 10.586l3.293-3.293a1 1 0 0 1 1.414 1.414Z"/>
			</svg>
			<span class="group-hover:underline group-hover:underline-offset-4">{{ text }}</span>
		</button>
	</li>
</template>

<script lang="ts">

export default {
	props: {
		number: {
			type: Number,
			required: true
		},
		active: {
			type: Boolean,
			default: false
		},
		text: {
			type: String,
			required: true
		},
		url: {
			type: String,
			default: ""
		}
	},
	methods: {
		navigate(url: string) {
			if (!url) {
				return;
			}
			window.location.assign(url);
		}
	},
	computed: {
		isFinished() {
			return !this.url;
		}
	}
};
</script>
