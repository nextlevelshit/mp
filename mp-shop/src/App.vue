<template>
	<Header/>
	<router-view :key="$route.path"></router-view>
	<Footer/>
</template>
<script>
import Header from "@/components/Header.vue";
import Footer from "@/components/Footer.vue";

export default {
	components: {Footer, Header}
};
</script>
