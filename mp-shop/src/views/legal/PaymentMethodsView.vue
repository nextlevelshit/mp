<template>
	<main class="pt-4 container mx-auto">
		<Title :level="1" html-tag="h1">Zahlungsarten</Title>
		Für Ihren Einkauf bei uns stehen Ihnen folgende Zahlungsarten zur Verfügung:

		<!-- <br><br>
		<Title :level="2" html-tag="h2">Lastschrift</Title> Sie geben Ihre Kontoinformationen an und wir buchen den fälligen Betrag bei Versand der Ware von Ihrem Konto ab.
		<br>Ihre Ware kann damit umgehend verschickt werden. -->

		<br><br>
		<Title :level="2" html-tag="h2">Rechnung</Title>
		Lieferung auf Rechnung - bezahlen Sie erst, wenn Sie die Ware erhalten haben.

		<br><br>
		<Title :level="2" html-tag="h2">Vorkasse</Title>
		Bitte beachten Sie, dass es bei Zahlung per Überweisung bis zu 3 Werktage dauern kann, bis Ihre Zahlung auf
		unser Konto eingeht.
		<br>Wir versenden die Ware sofort nach Geldeingang. Sie erhalten die Ware innerhalb von 4-7 Werktagen.

		<!-- <Title :level="2" html-tag="h2">muellerprints.</Title>
		<p><strong>Empfänger</strong>: Max Müller</p>
		<p><strong>IBAN</strong>: DE73 6009 0100 0525 0360 08</p>
		<p><strong>BIC</strong>: VOBADESS</p>
		<p><strong>Bank</strong>: Stuttgarter Volksbank eG</p> -->

		<br><br>
		<Title :level="2" html-tag="h2">Nachnahme</Title>
		Bei Bezahlung per Nachnahme entstehen zusätzliche Kosten.

		<br><br>
		<Title :level="2" html-tag="h2">Kreditkarte</Title>
		Sie können mit VISA oder MasterCard bezahlen.
		<!-- <br><img ng-src="/assets/logos/payment-icons.png"> -->
		<br>Bei Zahlung per Kreditkarte erhalten wir Ihre Zahlung sofort und können gleich mit der Bearbeitung Ihrer
		Bestellung beginnen.
		<br>Beim Bestellvorgang benötigen wir zusätzlich zur Kartennummer die Gültigkeit und die Prüfziffer der Karte.
	</main>
</template>

<script lang="ts">

import {defineComponent} from "vue";
import Title from "@/components/Title.vue";

export default defineComponent({
	components: {Title}
})
</script>
