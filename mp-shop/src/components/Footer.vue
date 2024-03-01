<template>
	<div class="bg-gray-800 text-gray-400 py-12 tracking-wide mt-40">
		<div class="container mx-auto">
			<div class="flex">
				<div class="w-1/4">
					Hergestellt aus 100% Altpapier<br/>
					Lokale Produktion in Stuttgart<br/>
					Handarbeit made in Germany<br/>
					Unverpackt und vegan<br/>
					Gratis Versand ab 25,90 €
				</div>
				<div class="w-1/4">
					Whatever
				</div>
				<div class="w-1/2 flex flex-col gap-1">
					<a href="/imprint" class="hover:text-white" @click="trackEvent(`footer-imprint-clicked`)">Impressum</a>
					<a href="/privacy" class="hover:text-white" @click="trackEvent(`footer-privacy-clicked`)">Datenschutzerklärung</a>
					<a href="/terms" class="hover:text-white" @click="trackEvent(`footer-terms-clicked`)">Allgemeine Geschäftsbedingungen (AGB)</a>
					<a href="/payment" class="hover:text-white" @click="trackEvent(`footer-payment-clicked`)">Zahlungsarten</a>
					<a href="/delivery" class="hover:text-white" @click="trackEvent(`footer-delivery-clicked`)">Versandarten</a>
				</div>
			</div>
		</div>
	</div>
</template>

<script setup lang="ts">
import {trackEvent} from "@/util/trackEvent";
</script>
