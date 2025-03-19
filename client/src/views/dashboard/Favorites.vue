<template>
  <Title
    title="Mes favoris"
    subtitle="Retrouver ici vos séries d'exercices favoris... même hors-ligne !"
  />

  <div v-if="!levels || levels.length === 0" class="py-5">
    <p class="text-gray-500 text-lg italic">
      Vous n'avez pas encore de favoris
    </p>
  </div>

  <section v-else class="flex flex-col" v-for="level in levels" :key="level.id">
    <h2 class="text-2xl font-semibold mb-2">
      {{ level.title }} ({{ level.subtitle }})
    </h2>
    <Carousel v-bind="carouselConfig(level.exercisesSeries.length)">
      <Slide
        v-for="exercisesSerie in level.exercisesSeries"
        :key="exercisesSerie.id"
      >
        <div class="p-2">
          <ExercisesSerieCard
            :exercisesSerie="exercisesSerie"
            :routerParams="{ levelTitle: level.title }"
            @removeFavorite="onRemoveFavorite"
          />
        </div>
      </Slide>
      <template #addons>
        <Navigation />
        <Pagination />
      </template>
    </Carousel>
  </section>
  <LoadingSpinner v-if="isLoading" />
</template>

<script lang="ts" setup>
import { onMounted, ref } from "vue";
import Title from "../../components/Dashboard/Layout/Title.vue";
import { Database } from "../../utils/database.utils";
import "vue3-carousel/carousel.css";
import { Carousel, Slide, Pagination, Navigation } from "vue3-carousel";
import ExercisesSerieCard from "../../components/Dashboard/Card/ExercisesSerieCard.vue";
import type Level from "../../interface/level.interface";
import LoadingSpinner from "../../components/LoadingSpinner.vue";
import type ExercisesSerie from "../../interface/exercises-serie.interface";

const levels = ref<Level[]>();
const isLoading = ref(false);

const carouselConfig = (items: number) => {
  return {
    wrapAround: items > 3 ? true : false,
    breakpoints: {
      300: {
        itemsToShow: 1,
      },
      900: {
        itemsToShow: items > 2 ? 2 : items - 1,
      },
      1200: {
        itemsToShow: items > 3 ? 3 : items - 1,
      },
    },
  };
};

const fetchFavorites = async () => {
  try {
    isLoading.value = true;
    const { data } = await Database.get(`level/favorites`);
    levels.value = data;
  } catch (error) {
    console.error("Erreur lors de la récupération des favoris:", error);
  } finally {
    isLoading.value = false;
  }
};

const onRemoveFavorite = (serieId: number) => {
  levels.value = levels.value?.filter((level: Level) => {
    level.exercisesSeries = level.exercisesSeries.filter(
      (exercisesSerie: ExercisesSerie) => exercisesSerie.id !== serieId
    );
    return level.exercisesSeries.length > 0;
  });
};

onMounted(() => {
  fetchFavorites();
});
</script>
