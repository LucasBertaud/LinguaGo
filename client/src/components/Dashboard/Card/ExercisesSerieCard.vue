<template>
    <div class="p-4 cursor-pointer transition hover:scale-105 active:scale-95">
      <div class="flex rounded-lg h-full bg-gray-100 p-8 flex-col">
        <div class="flex flex-col justify-center items-center mb-3">
          <i class="[&>svg]:w-14 [&>svg]:h-14 mb-4 opacity-15" :class="percentageCompleted == 100 && '[&>svg]:fill-secondary !opacity-100'" v-html="svgContent"></i>
          <h2 class="text-gray-900 text-lg title-font font-medium">{{ title }}</h2>
          <p class="text-gray-500 text-sm italic">Réussir {{ exercises.length > 1 ? "les" : "" }} {{ exercises.length }} {{ exercises.length > 1 ? "exercices" : "exercice" }} pour compléter la série.</p>
          <div class="w-full bg-gray-200 rounded-full h-3.5 dark:bg-gray-200 my-4">
            <div class="bg-primary h-3.5 rounded-full" :class="percentageCompleted == 100 && '!bg-secondary'" :style="{'width': percentageCompleted + '%'}"></div>
          </div>
        </div>
        <div class="flex-grow">
          <p class="leading-relaxed text-base">{{ description }}</p>
          <a class="mt-3 text-primary inline-flex items-center">Commencer la série
            <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="w-4 h-4 ml-2" viewBox="0 0 24 24">
              <path d="M5 12h14M12 5l7 7-7 7"></path>
            </svg>
          </a>
        </div>
      </div>
    </div>
</template>

<script setup lang="ts">
import { defineProps, onMounted, ref } from 'vue';
import { loadSvg } from '../../../utils/loadSvg';
import type ExercisesSerie from '../../../interface/exercises-serie.interface';

const props = defineProps<ExercisesSerie>();
const percentageCompleted = ref<number>(0);

const getCompletedExercisesLength = () => {
  return props.exercises.filter((exercise) => exercise.usersCompleted.length > 0).length;
};

const getPercentageCompleted = async () => {
  return (getCompletedExercisesLength() / props.exercises.length) * 100 || 0;
};

const svgContent = ref<string | null>(null);

onMounted(async () => {
  svgContent.value = await loadSvg(`/assets/images/icons/achievement.svg`);
  percentageCompleted.value = await getPercentageCompleted();
});
</script>