<script lang="ts">
import {type PropType, h} from "vue";
import debug from "debug";

type Level = 1 | 2 | 3 | 4 | 5;
type HtmlTag = "h1" | "h2" | "h3" | "h4" | "h5" | "p";

const classes: Record<Level, string> = {
	1: "text-3xl font-bold mb-5 mt-6",
	2: "text-2xl font-bold mb-4 mt-5",
	3: "text-xl mt-2 font-semibold mb-1",
	4: "text-md mt-2 mb-1 font-semibold",
	5: "text-base mb-1 font-semibold mt-2",
};

const logger = debug("app:i:title-component");
const verbose = debug("app:v:title-component");

export default {
	props: {
		level: {
			type: Number,
			default: 1
		},
		htmlTag: {
			type: String as PropType<HtmlTag>,
			default: "p"
		},
		classes: {
			type: String,
			default: ""
		}
	},
	render() {
		if (!this.$slots["default"]) {
			logger("Cannot render title component, no default slot provided");
			return;
		}

		return h(this.htmlTag, {
			class: classes[this.level] + " " + this.classes,
		}, this.$slots["default"]!())
	},
}
</script>
