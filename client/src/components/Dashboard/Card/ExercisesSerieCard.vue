<template>
  <div 
    v-on:keyup.enter="navigateToExercises"
    tabindex="0"
    class="relative group p-4 focus-visible:scale-105 h-full transition hover:scale-105">
    <FavoriteButton :serie-id="exercisesSerie.id" :user-favorite-serie="userFavoriteSerie" @remove-favorite="onRemoveFavorite" />
    <div 
      class="cursor-pointer transition active:scale-95 h-full" 
      @click="navigateToExercises">
      <div class="flex rounded-lg h-full bg-gray-100 p-8 flex-col">
        <div class="flex flex-col justify-center items-center mb-3">
          <Icon 
            svg-path="/assets/images/icons/achievement.svg" 
            :options="{
              dynamicClasses: `
                mb-4 opacity-15
                [&>svg]:w-14
                [&>svg]:h-14 
                ${percentageCompleted == 100 && '[&>svg]:!fill-secondary !opacity-100'}`
            }" />
          <h2 class="text-gray-900 text-lg title-font font-medium">{{ exercisesSerie.title }}</h2>
          <p class="text-gray-500 text-sm italic">Réussir {{ exercisesSerie.exercises.length > 1 ? "les" : "" }} {{ exercisesSerie.exercises.length }}
            {{ exercisesSerie.exercises.length > 1 ? "exercices" : "exercice" }} pour compléter la série.</p>
          <div class="w-full bg-gray-200 rounded-full h-3.5 dark:bg-gray-200 my-4">
            <div class="bg-primary h-3.5 rounded-full" :class="percentageCompleted == 100 && '!bg-secondary'"
              :style="{ 'width': percentageCompleted + '%' }"></div>
          </div>
        </div>
        <div class="flex-grow flex flex-col items-center">
          <p class="leading-relaxed text-base flex-grow">{{ exercisesSerie.description }}</p>
          <a class="mt-3 text-primary inline-flex items-center">Commencer la série
            <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              class="w-4 h-4 ml-2" viewBox="0 0 24 24">
              <path d="M5 12h14M12 5l7 7-7 7"></path>
            </svg>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { loadSvg } from '../../../utils/loadSvg';
import Icon from '../../Icon.vue';
import FavoriteButton from '../Button/FavoriteButton.vue';
import store from '../../../store';
import type ExercisesSerie from '../../../interface/exercises-serie.interface';
import type UserFavoriteSerie from '../../../interface/user-favorite-serie.interface';

const props = defineProps<{
  exercisesSerie: ExercisesSerie;
  routerParams?: { levelTitle: string };
}>();
const emit = defineEmits<{
  removeFavorite: [number];
}>();
const percentageCompleted = ref<number>(0);
const router = useRouter();
const userFavoriteSerie: UserFavoriteSerie | undefined = props.exercisesSerie.favoriteUsers.find((favorite) => favorite.userId === store.getters.getUser.id && favorite.serieId === props.exercisesSerie.id);

const getCompletedExercisesLength = () => {
  return props.exercisesSerie.exercises.filter((exercise) => exercise.usersCompleted.length > 0).length;
};

const getPercentageCompleted = async () => {
  return (getCompletedExercisesLength() / props.exercisesSerie.exercises.length) * 100 || 0;
};

const svgContent = ref<string | null>(null);

const navigateToExercises = () => {
  router.push({ name: 'Exercises', params: { 
    serieId: props.exercisesSerie.id,
    levelTitle: props.routerParams?.levelTitle
  }});
};

const onRemoveFavorite = () => {
  emit('removeFavorite', props.exercisesSerie.id);
} 

onMounted(async () => {
  svgContent.value = await loadSvg(`/assets/images/icons/achievement.svg`);
  percentageCompleted.value = await getPercentageCompleted();
});
</script>