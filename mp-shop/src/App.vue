<template>
  <Header/>
  <main class="pt-4 container mx-auto">
		<router-view :key="$route.path"></router-view>
	</main>
</template>
<script>
import Header from "@/components/Header.vue";

export default {
  components: {Header}
};
</script>
