<template>
    <section class="py-20 px-6 h-screen bg-gray-100 text-center">
      <h2 class="text-4xl font-bold text-primary mb-10">Les niveaux</h2>
      <div class="flex justify-center">
          <div class="flex flex-wrap justify-center w-220"> <!-- Ajout de gap pour espacer les cartes -->
            <div v-for="level in levels" :key="level.id" class="w-full sm:w-1/2 p-6"> <!-- Utilisation des tailles responsives -->
              <router-link :to="{ name: 'Exercises', params: { levelId: level.id } }">
                <LevelCard :level="level.level" />
              </router-link>
            </div>
          </div>
      </div>
    </section>
  </template>
  

<script setup lang="ts">
import { ref } from 'vue';
import LevelCard from './LevelCard.vue';

const levels = ref([
    { id: 3, level: 'A1' },
    { id: 4, level: 'A2' },
    { id: 1, level: 'B1' },
    { id: 2, level: 'B2' },
    { id: 5, level: 'C1' },
]);
</script>