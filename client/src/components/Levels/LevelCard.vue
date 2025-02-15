<template>
    <div 
      class="bg-white p-6 rounded-lg shadow-lg border-t-4 transition-transform transform hover:scale-105 hover:shadow-xl" 
      :class="level == 'A1' ? 'border-A1' : level == 'A2' ? 'border-A2' : level == 'B1' ? 'border-B1' : level == 'B2' ? 'border-B2' : level == 'C1' ? 'border-C1' : null">
      <h3 
        class="text-2xl font-bold mb-3"
        :class="level == 'A1' ? 'text-A1' : level == 'A2' ? 'text-A2' : level == 'B1' ? 'text-B1' : level == 'B2' ? 'text-B2' : level == 'C1' ? 'text-C1' : null">
        {{ level ?? "Niveau non défini" }}
      </h3>
      <p class="text-text">{{ description }}</p>
      <p 
        class="text-3xl font-bold my-4"
        :class="level == 'A1' ? 'text-A1' : level == 'A2' ? 'text-A2' : level == 'B1' ? 'text-B1' : level == 'B2' ? 'text-B2' : level == 'C1' ? 'text-C1' : null">
        {{ pointsWon ?? 0 }}/{{ winablePoints ?? 0 }} pts
      </p>
      <button 
        class="text-white py-2 px-4 rounded-full shadow-md transition-all duration-300 ease-in-out transform hover:bg-opacity-80"
        :class="level == 'A1' ? 'bg-A1' : level == 'A2' ? 'bg-A2' : level == 'B1' ? 'bg-B1' : level == 'B2' ? 'bg-B2' : level == 'C1' ? 'bg-C1' : null">
        S'exercer
      </button>
    </div>
  </template>
  

<script setup lang="ts">
defineProps<{
  level: string
  description?: number
  pointsWon?: number
  winablePoints?: number
}>()
</script>