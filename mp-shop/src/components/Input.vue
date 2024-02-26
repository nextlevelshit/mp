<template>
	<label class="relative w-full border border-gray-300 p-2 rounded-md cursor-text h-12 peer-">
		<span :class="spanClasses" class="absolute left-2 top-0 transition-all select-none">{{ label }}</span>
		<input :value="modelValue" @input="update(($event.target as HTMLInputElement).value)" :required="required"
			   class="outline-none w-full rounded-sm pt-3 border-transparent" placeholder=""
			   :autocomplete="autocomplete" :aria-label="label" @focus="inputFocused = true"
			   @blur="inputFocused = false"/>
	</label>
</template>

<script lang="ts">
import debug from "debug";
import type {PropType} from "vue";

type Autocomplete =
	"given-name"
	| "family-name"
	| "email"
	| "tel"
	| "street-address"
	| "postal-code"
	| "country-name"
	| "off"
	| "on"
	| "name"
	| "honorific-prefix"
	| "honorific-suffix"
	| "nickname"
	| "organization-title"
	| "organization"
	| "username"
	| "new-password"
	| "current-password"
	| "one-time-code";

const logger = debug("app:i:input-component");
const verbose = debug("app:v:input-component");

export default {
	props: {
		modelValue: String,
		label: String,
		required: Boolean,
		labelClass: String,
		inputClass: String,
		autocomplete: {
			type: String as PropType<Autocomplete>,
			default: "off"
		}
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
