<template>
	<main class="pt-4 container mx-auto">
		<Title :level="1" html-tag="h1">Impressum</Title>
		<Title :level="2" html-tag="h2">muellerprints.</Title>
		<b>Inhaber:</b> Max Müller
		<br>
		<br>Rotenbergstraße 39
		<br>70190 Stuttgart
		<br>
		<br>T + 49 (0)711 / 262 49 64
		<br>F + 49 (0)711 / 262 48 60
		<br>muellerprints@t-online.de
		<br>
		<br><a href="https://www.muellerprints.de" target="_blank" class="underline">www.muellerprints.de</a>
		<br>
		<br>Umsatzsteuer-Identifikationsnummer gemäß § 27 a Umsatzsteuergesetz: DE 147595459
		<br>
		<br>Plattform der EU-Kommission zur Online-Streitbeilegung: <a href="https://ec.europa.eu/consumers/odr">https://ec.europa.eu/consumers/odr</a>
		<br>Wir sind zur Teilnahme an einem Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle weder
		verpflichtet noch bereit.
		<br>
		<br>
		<span class="glyphicon glyphicon-copyright-mark"></span> muellerprints. Stuttgart 2018
		<br>
		<br>
		Mitglied der Initiative "Fairness im Handel".
		<br>Nähere Informationen: <a href="https://www.fairness-im-handel.de" target="_blank" class="underline">https://www.fairness-im-handel.de</a>
	</main>
</template>

<script lang="ts">

import {defineComponent} from "vue";
import Title from "@/components/Title.vue";

export default defineComponent({
	components: {Title}
})
</script>
