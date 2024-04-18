<template>
	<swiper
		:modules="modules"
		:slides-per-view="6"
		:space-between="50"
		navigation
		:pagination="{ clickable: true }"
		@swiper="onSwiper"
		@slideChange="onSlideChange"
		:centeredSlides="false"
		:loop="false"
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
		<slot />
<!--		<swiper-slide>-->
<!--			<div class="bg-indigo-50 rounded-2xl h-96 flex justify-center items-center">-->
<!--				<span class="text-3xl font-semibold text-indigo-600">Slide 1</span>-->
<!--			</div>-->
<!--		</swiper-slide>-->
<!--		<swiper-slide>-->
<!--			<div class="bg-indigo-50 rounded-2xl h-96 flex justify-center items-center">-->
<!--				<span class="text-3xl font-semibold text-indigo-600">Slide 2</span>-->
<!--			</div>-->
<!--		</swiper-slide>-->
<!--		<swiper-slide>-->
<!--			<div class="bg-indigo-50 rounded-2xl h-96 flex justify-center items-center">-->
<!--				<span class="text-3xl font-semibold text-indigo-600">Slide 3</span>-->
<!--			</div>-->
<!--		</swiper-slide>-->
<!--		<swiper-slide>-->
<!--			<div class="bg-indigo-50 rounded-2xl h-96 flex justify-center items-center">-->
<!--				<span class="text-3xl font-semibold text-indigo-600">Slide 4</span>-->
<!--			</div>-->
<!--		</swiper-slide>-->
<!--		<swiper-slide>-->
<!--			<div class="bg-indigo-50 rounded-2xl h-96 flex justify-center items-center">-->
<!--				<span class="text-3xl font-semibold text-indigo-600">Slide 5</span>-->
<!--			</div>-->
<!--		</swiper-slide>-->
<!--		<swiper-slide>-->
<!--			<div class="bg-indigo-50 rounded-2xl h-96 flex justify-center items-center">-->
<!--				<span class="text-3xl font-semibold text-indigo-600">Slide 6</span>-->
<!--			</div>-->
<!--		</swiper-slide>-->
<!--		<swiper-slide>-->
<!--			<div class="bg-indigo-50 rounded-2xl h-96 flex justify-center items-center">-->
<!--				<span class="text-3xl font-semibold text-indigo-600">Slide 7</span>-->
<!--			</div>-->
<!--		</swiper-slide>-->
<!--		<swiper-slide>-->
<!--			<div class="bg-indigo-50 rounded-2xl h-96 flex justify-center items-center">-->
<!--				<span class="text-3xl font-semibold text-indigo-600">Slide 8</span>-->
<!--			</div>-->
<!--		</swiper-slide>-->
	</swiper>
</template>
<script>
// import Swiper core and required modules
import {Navigation, A11y} from 'swiper/modules';

// Import Swiper Vue.js components
import {Swiper, SwiperSlide} from 'swiper/vue';

// Import Swiper styles
import 'swiper/css';
import 'swiper/css/navigation';

// Import Swiper styles
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
