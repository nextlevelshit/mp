<template>
	<Header/>
	<router-view :key="$route.path"></router-view>
</template>
<script>
import Header from "@/components/Header.vue";

export default {
	components: {Header}
};
</script>
