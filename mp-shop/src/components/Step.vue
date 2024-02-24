<template>
	<li :class="{ 'text-black': active }" class="flex items-center">
		<span class="flex items-center justify-center w-5 h-5 me-2 text-xs border rounded-full shrink-0"
			  :class="{ 'border-black': active, 'border-gray-500': !active }">
		  {{ number }}
		</span>
		<span>{{ text }}</span>
	</li>
</template>

<script>
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
		}
	}
};
</script>
