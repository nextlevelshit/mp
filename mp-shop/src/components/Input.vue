<template>
	<label class="relative w-full border border-gray-300 p-2 rounded-md cursor-text h-12 peer-">
		<span :class="spanClasses" class="absolute left-2 top-0 transition-all">{{ label }}</span>
		<input ref="input" v-model="internalValue" :required="required" class="outline-none w-full rounded-sm pt-3 border-transparent" placeholder="" :aria-label="label" @focus="inputFocused = true" @blur="inputFocused = false"/>
	</label>
</template>

<script lang="ts">
export default {
	props: {
		label: String,
		value: String,
		required: Boolean,
		labelClass: String,
		inputClass: String
	},
	data() {
		return {
			internalValue: this.value,
			inputFocused: false
		};
	},
	computed: {
		spanClasses() {
			return {
				'text-md pt-3': !this.inputFocused && !this.internalValue,
				'text-xs pt-1': this.inputFocused || this.internalValue,
				'text-gray-500': !this.inputFocused && !this.internalValue,
				'text-gray-400': this.inputFocused || this.internalValue,
			};
		}
	},
	watch: {
		value(newValue) {
			this.internalValue = newValue;
		},
		internalValue(newValue) {
			this.$emit('input', newValue);
		}
	},
}
</script>
