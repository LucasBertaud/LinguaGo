<template>
    <div 
      class="bg-white h-full w-full p-6 rounded-lg shadow-lg border-t-4 transition-transform transform hover:scale-105 hover:shadow-xl" 
      :class="title == 'A1' ? 'border-A1' : title == 'A2' ? 'border-A2' : title == 'B1' ? 'border-B1' : title == 'B2' ? 'border-B2' : title == 'C1' ? 'border-C1' : null">
      <h3 
        class="text-2xl font-bold mb-3"
        :class="title == 'A1' ? 'text-A1' : title == 'A2' ? 'text-A2' : title == 'B1' ? 'text-B1' : title == 'B2' ? 'text-B2' : title == 'C1' ? 'text-C1' : null">
        {{ title }} ({{ subtitle }})
      </h3>
      <p class="text-text">{{ description }}</p>
      <p 
        class="text-3xl font-bold my-4"
        :class="title == 'A1' ? 'text-A1' : title == 'A2' ? 'text-A2' : title == 'B1' ? 'text-B1' : title == 'B2' ? 'text-B2' : title == 'C1' ? 'text-C1' : null">
        {{ pointsWon ?? 0 }}/{{ winablePoints ?? 0 }} pts
      </p>
      <router-link
        class="text-white py-2 px-4 rounded-full shadow-md transition-all duration-300 ease-in-out transform hover:bg-opacity-80"
        :class="title == 'A1' ? 'bg-A1' : title == 'A2' ? 'bg-A2' : title == 'B1' ? 'bg-B1' : title == 'B2' ? 'bg-B2' : title == 'C1' ? 'bg-C1' : null"
        :to="{ name: 'Exercises', params: { level: title } }"> 
        S'exercer
      </router-link>
    </div>
  </template>
  

<script setup lang="ts">
import type Level from '../../interface/level.interface';
defineProps<Level>();
</script>