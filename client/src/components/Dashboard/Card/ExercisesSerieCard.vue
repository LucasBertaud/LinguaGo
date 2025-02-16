<template>
    <div class="p-4 cursor-pointer transition hover:scale-105 active:scale-95">
        <div class="flex rounded-lg h-full bg-gray-100 p-8 flex-col">
          <div class="flex justify-center mb-3">
            <h2 class="text-gray-900 text-lg title-font font-medium">{{ title }}</h2>
          </div>
          <div class="flex-grow">
            <p class="leading-relaxed text-base">{{ description }}</p>
            <a class="mt-3 text-indigo-500 inline-flex items-center">Commencer la série
              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="w-4 h-4 ml-2" viewBox="0 0 24 24">
                <path d="M5 12h14M12 5l7 7-7 7"></path>
              </svg>
            </a>
          </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue';
import type ExercisesSerie from '../../../interface/exercises-serie.interface';

defineProps<ExercisesSerie>();
</script>