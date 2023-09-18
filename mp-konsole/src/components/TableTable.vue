<template>
	<section v-if="list" class="container mx-auto">
		<div class="sm:flex sm:items-center sm:justify-between">
			<div>
				<div class="flex items-center gap-x-3">
					<h2 class="text-lg font-medium text-gray-800 dark:text-white">
						{{ list.title }}
					</h2>

					<span
						class="px-3 py-1 text-xs tfext-blue-600 bg-blue-100 rounded-full dark:bg-gray-800 dark:text-blue-400"
						>{{ list.length }} Einträge</span
					>
				</div>
			</div>

			<div class="flex items-center mt-4 gap-x-3">
				<button
					class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600"
				>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 24 24"
						stroke-width="1.5"
						stroke="currentColor"
						class="w-5 h-5"
					>
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"
						/>
					</svg>

					<span>Neuer Eintrag</span>
				</button>
			</div>
		</div>

		<div class="mt-6 md:flex md:items-center md:justify-between">
			<div
				v-if="list.options"
				class="inline-flex overflow-hidden bg-white border divide-x rounded-lg dark:bg-gray-900 rtl:flex-row-reverse dark:border-gray-700 dark:divide-gray-700"
			>
				<button
					v-for="([label], i) in [...list.options]"
					:class="{ 'bg-gray-100': i === 0 }"
					:key="i"
					class="px-5 py-2 text-xs font-medium text-gray-600 transition-colors duration-200 sm:text-sm dark:bg-gray-800 dark:text-gray-300"
				>
					{{ label }}
				</button>
			</div>

			<div class="relative flex items-center mt-4 md:mt-0">
				<span class="absolute">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 24 24"
						stroke-width="1.5"
						stroke="currentColor"
						class="w-5 h-5 mx-3 text-gray-400 dark:text-gray-600"
					>
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z"
						/>
					</svg>
				</span>

				<input
					type="text"
					placeholder="Search"
					class="block w-full py-1.5 pr-5 text-gray-700 bg-white border border-gray-200 rounded-lg md:w-80 placeholder-gray-400/70 pl-11 rtl:pr-11 rtl:pl-5 dark:bg-gray-900 dark:text-gray-300 dark:border-gray-600 focus:border-blue-400 dark:focus:border-blue-300 focus:ring-blue-300 focus:outline-none focus:ring focus:ring-opacity-40"
				/>
			</div>
		</div>

		<div class="flex flex-col mt-6">
			<div class="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
				<div class="inline-block min-w-full py-2 align-middle md:px-6 lg:px-8">
					<div
						class="overflow-hidden border border-gray-200 dark:border-gray-700 md:rounded-lg"
					>
						<table
							class="min-w-full divide-y divide-gray-200 dark:divide-gray-700"
						>
							<thead class="bg-gray-50 dark:bg-gray-800">
								<tr>
									<th
										v-for="(header, i) in list.header"
										scope="col"
										:key="i"
										class="py-3.5 px-4 text-sm font-normal text-left rtl:text-right text-gray-500 dark:text-gray-400"
									>
										{{ header }}
									</th>
									<th scope="col" class="relative py-3.5 px-4">
										<span class="sr-only">Bearbeiten</span>
									</th>
								</tr>
							</thead>
							<tbody
								class="bg-white divide-y divide-gray-200 dark:divide-gray-700 dark:bg-gray-900"
							>
								<tr v-for="(row, i) in list.rows" :key="i">
									<td
										v-for="(cell, i) in row"
										:key="i"
										class="px-4 py-4 text-sm font-medium whitespace-nowrap"
									>
										<div>
											<p
												class="font-medium text-gray-800 dark:text-white"
											>
												{{  cell }}
											</p>
										</div>
									</td>

									<td class="px-4 py-4 text-sm whitespace-nowrap">
										<button
											class="px-1 py-1 text-gray-500 transition-colors duration-200 rounded-lg dark:text-gray-300 hover:bg-gray-100"
										>
											<svg
												xmlns="http://www.w3.org/2000/svg"
												fill="none"
												viewBox="0 0 24 24"
												stroke-width="1.5"
												stroke="currentColor"
												class="w-6 h-6"
											>
												<path
													stroke-linecap="round"
													stroke-linejoin="round"
													d="M12 6.75a.75.75 0 110-1.5.75.75 0 010 1.5zM12 12.75a.75.75 0 110-1.5.75.75 0 010 1.5zM12 18.75a.75.75 0 110-1.5.75.75 0 010 1.5z"
												/>
											</svg>
										</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
	<div v-else class="py-8">Loading data...</div>
</template>

<script>
export default {
	props: ["list"],
	data() {
		return {
			error: null
		};
	},
	created() {
		console.log("Table created with", this.list);
	}
};
</script>
