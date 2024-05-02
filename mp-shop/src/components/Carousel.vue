<template>
	<Swiper
		:modules="modules"
		:slides-per-view="6"
		:space-between="50"
		navigation
		:pagination="{ clickable: true }"
		@swiper="onSwiper"
		@slideChange="onSlideChange"
		:centeredSlides="false"
		:loop="false"
		:mousewheel="true"
		:grabCursor="true"
		:keyboard="true"
		:breakpoints="{
			1920: {
           slidesPerView: 4,
           spaceBetween: 30
         },
         1028: {
           slidesPerView: 2,
           spaceBetween: 10
         },
         990: {
           slidesPerView: 1,
           spaceBetween: 0
         }
		}"
	>
		<slot/>
	</Swiper>
</template>
<script>
import {Navigation, A11y} from 'swiper/modules';
import {Swiper, SwiperSlide} from 'swiper/vue';
import 'swiper/css';
import 'swiper/css/navigation';

export default {
	components: {
		Swiper,
		SwiperSlide,
	},
	setup() {
		const onSwiper = (swiper) => {
			console.log(swiper);
		};
		const onSlideChange = () => {
			console.log('slide change');
		};

		return {
			onSwiper,
			onSlideChange,
			modules: [Navigation, A11y],
		};
	},
};
</script>


<style>
.swiper {
	@apply pb-20 overflow-visible;
}

.swiper-button-next,
.swiper-button-prev {
	@apply absolute left-auto right-0 bottom-0 top-auto rounded-full p-10 hover:shadow-sm hover:bg-gray-100 focus:bg-gray-100 focus:ring-4 ring-gray-500 focus:ring-offset-2 bg-gray-200 text-gray-400 text-sm transition-colors scale-75 font-bold;
}

.swiper-button-prev {
	@apply right-20;
}

.swiper-button-next:after {
	@apply ml-2;
}

.swiper-button-prev:after {
	@apply mr-2;
}
</style>
