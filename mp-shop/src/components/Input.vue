<template>
	<label class="relative w-full border border-gray-300 p-2 rounded-md cursor-text h-12 peer-">
		<span :class="spanClasses" class="absolute left-2 top-0 transition-all select-none">{{ label }}</span>
		<input :value="modelValue" @input="update(($event.target as HTMLInputElement).value)" :required="required" class="outline-none w-full rounded-sm pt-3 border-transparent" placeholder="" :aria-label="label" @focus="inputFocused = true" @blur="inputFocused = false"/>
	</label>
</template>

<script lang="ts">
import debug from "debug";

const logger = debug("app:i:input-component");
const verbose = debug("app:v:input-component");

export default {
	props: {
		modelValue: String,
		label: String,
		required: Boolean,
		labelClass: String,
		inputClass: String
	},
	data() {
		return {
			inputFocused: false
		};
	},
	computed: {
		spanClasses() {
			return {
				'text-md pt-3': !this.inputFocused && !this.modelValue,
				'text-xs pt-1': this.inputFocused || this.modelValue,
				'text-gray-500': !this.inputFocused && !this.modelValue,
				'text-gray-400': this.inputFocused || this.modelValue,
			};
		}
	},
	methods: {
		update(newValue?: string) {
			newValue && this.$emit("update:modelValue", newValue);
		}
	}
}
</script>
