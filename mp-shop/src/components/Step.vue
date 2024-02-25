<template>
	<li :class="{ 'text-black': active, 'cursor-pointer hover:text-black group': url }" class="flex">
		<button class="flex items-center" @click="navigate(url)">
			<span class="flex items-center justify-center w-5 h-5 me-2 text-xs border rounded-full shrink-0"
				  :class="{ 'border-black': active, 'border-gray-400': !active }">
			  {{ number }}
			</span>
			<span class="group-hover:underline">{{ text }}</span>
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
	}
};
</script>
