<template>
    <section class="py-20 px-6 bg-gray-100 text-center">
      <h2 class="text-4xl font-bold text-primary mb-10">Les niveaux</h2>
      <div class="flex justify-center">
          <div class="flex flex-wrap justify-center w-220">
            <div v-for="level in levels" :key="level.id" class="w-full sm:w-1/2 p-6">
                <LevelCard :title="level.title" :subtitle="level.subtitle" :description="level.description" :id="level.id" :winable-points="level.winablePoints" />
            </div>
          </div>
      </div>
    </section>
  </template>
  

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import LevelCard from './LevelCard.vue';
import type Level from '../../interface/level.interface';
import Database from '../../utils/database';

const levels = ref<Level[]>([]);

const fetchLevels = async () => {
    const response = Database.getAll('level')
    response.then((data) => {
        levels.value = data.map((level: Level) => {
            return level;
        });
    }).catch((error) => {
        console.error(error);
    });
};

onMounted(() => {
    fetchLevels();
});

</script>