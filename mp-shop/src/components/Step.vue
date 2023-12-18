<template>
  <div class="relative">
    <div
        class="flex items-center justify-center h-12 w-12 rounded-full border-2 border-gray-200"
        :class="{ 'bg-blue-500 text-white': active, 'bg-green-500 text-white': completed }"
    >
      <span v-if="completed">&#10003;</span>
      <span v-else>{{ number }}</span>
    </div>
    <div
        class="absolute top-16 left-1/2 transform -translate-x-1/2 text-sm text-center"
        :class="{ 'text-blue-500': active || completed }"
    >
      {{ text }}
    </div>
  </div>
</template>

<script lang="ts">
export default {
  props: ["number", "active", "completed", "text"],
};
</script>
