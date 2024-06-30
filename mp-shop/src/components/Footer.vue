<template>
	<footer class="bg-gray-800 text-white mt-40 pt-8 lg:pt-20">
		<div class="mx-auto container p-4 py-6 lg:py-8">
			<div class="md:flex md:justify-between">
				<div class="mb-12">
					<router-link
						to="/"
						class="flex items-center"
						@click="trackEvent(`footer-logo-clicked`)"
					>
						<span class="tracking-wide text-3xl font-bebas leading-none">
							MUELLERPRINTS.<br />Paperwork
						</span>
					</router-link>
				</div>
				<div class="grid grid-cols-1 gap-8 lg:gap-6 lg:grid-cols-3">
					<div>
						<h2 class="mb-4 text-sm font-semibold uppercase">Notizbücher</h2>
						<ul class="text-gray-400 font-medium mb-4">
							<li class="mb-2 lg:mb-4">
								<router-link
									:to="`/notebooks/${softCoverId}`"
									class="hover:text-white"
									@click="
										trackEvent(`footer-notebooks-softcover-clicked`)
									"
									>Softcover Fadenheftung
								</router-link>
							</li>
							<li>
								<router-link
									:to="`/notebooks/${hardCoverId}`"
									class="hover:text-white"
									@click="
										trackEvent(`footer-notebooks-hardcover-clicked`)
									"
									>Hardcover Fadenheftung
								</router-link>
							</li>
						</ul>
					</div>
					<div>
						<h2 class="mb-4 text-sm font-semibold uppercase">Notizhefte</h2>
						<ul class="text-gray-400 font-medium mb-4">
							<li class="mb-2 lg:mb-4">
								<router-link
									:to="`/notebooks/${bookletCoverId}`"
									class="hover:underline"
									@click="trackEvent(`footer-booklets-stiched-clicked`)"
									>Steppstichheftung
								</router-link>
							</li>
							<li>
								<router-link
									:to="`/notebooks/${bookletCoverId}`"
									class="hover:text-white"
									@click="trackEvent(`footer-booklets-glued-clicked`)"
									>Klebeheftung
								</router-link>
							</li>
						</ul>
					</div>
					<div>
						<h2 class="mb-4 text-sm font-semibold uppercase">Legal</h2>
						<ul class="text-gray-400 font-medium mb-4">
							<li class="mb-2 lg:mb-4">
								<router-link
									to="/legal/imprint"
									class="hover:text-white"
									@click="trackEvent(`footer-imprint-clicked`)"
									>Impressum
								</router-link>
							</li>
							<li class="mb-2 lg:mb-4">
								<router-link
									to="/legal/privacy"
									class="hover:text-white"
									@click="trackEvent(`footer-privacy-clicked`)"
									>Datenschutzerklärung
								</router-link>
							</li>
							<li class="mb-2 lg:mb-4">
								<router-link
									to="/legal/terms"
									class="hover:text-white"
									@click="trackEvent(`footer-terms-clicked`)"
									>Allgemeine Geschäftsbedingungen (AGB)
								</router-link>
							</li>
							<li class="mb-2 lg:mb-4">
								<router-link
									to="/legal/payment"
									class="hover:text-white"
									@click="trackEvent(`footer-payment-clicked`)"
									>Zahlungsarten
								</router-link>
							</li>
							<li>
								<router-link
									to="/legal/delivery"
									class="hover:text-white"
									@click="trackEvent(`footer-delivery-clicked`)"
									>Versandarten
								</router-link>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<hr class="my-6 sm:mx-auto border-gray-700 lg:my-8" />
			<div
				class="flex flex-col-reverse lg:flex-row items-center justify-between gap-8"
			>
				<span class="text-gray-400">
					© {{ new Date().getFullYear() }}
					<a href="/" class="hover:text-white">MUELLERPRINTS. PAPERWORK</a> –
					Alle Rechte vorbehalten
				</span>
				<div
					class="flex flex-col lg:flex-row mt-4 lg:mt-0 items-start lg:items-center text-gray-400 gap-8"
				>
					<span>
						Du kannst bei uns mit VISA, Mastercard und PayPal bezahlen
					</span>
					<img
						class="h-12"
						src="@/assets/visa-mastercard-paypal.svg"
						alt="VISA Mastercard PayPal Logos"
					/>
				</div>
			</div>
		</div>
	</footer>
</template>

<script setup lang="ts">
import { trackEvent } from "@/util/trackEvent";
import { softCoverId, hardCoverId, bookletCoverId } from "@/config/constants";
</script>
