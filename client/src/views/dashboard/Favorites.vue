<template>
    <Title title="Mes favoris" subtitle="Retrouver ici vos séries d'exercices favoris... même hors-ligne !" />
    <section class="flex flex-col" v-for="level in levels" :key="level.id">
        <h2 class="text-2xl font-semibold mb-2">{{ level.title }} ({{ level.subtitle }})</h2>
        <Carousel v-bind="carouselConfig(level.exercisesSeries.length < 3 ? level.exercisesSeries.length : 3)">
            <Slide v-for="exercisesSerie in level.exercisesSeries" :key="exercisesSerie.id">
                <div class="p-8">
                    <ExercisesSerieCard :exercisesSerie="exercisesSerie" @removeFavorite="onRemoveFavorite" />
                </div>
            </Slide>
            <template #addons>
                <Navigation />
                <Pagination />
            </template>
        </Carousel>
    </section>
</template>

<script lang="ts" setup>
import { onMounted, ref } from 'vue';
import Title from '../../components/Dashboard/Layout/Title.vue';
import Database from '../../utils/database';
import 'vue3-carousel/carousel.css'
import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel'
import ExercisesSerieCard from '../../components/Dashboard/Card/ExercisesSerieCard.vue';
import type Level from '../../interface/level.interface';
import type ExercisesSerie from '../../interface/exercises-serie.interface';

const levels = ref<Level[]>();

const carouselConfig = (items: number) => {
    return {
        itemsToShow: items >= 3 ? 3 : 1,
        wrapAround: true,
    }
}

const fetchFavorites = async () => {
    try {
        const response = await Database.getAll(`level/favorites`)
        levels.value = response;
        console.log(response);
    } catch (error) {
        console.error('Erreur lors de la récupération des favoris:', error);
    }
};

const onRemoveFavorite = (serieId: number) => {
    levels.value = levels.value?.filter((level: Level) => {
        level.exercisesSeries = level.exercisesSeries.filter((exercisesSerie: ExercisesSerie) => exercisesSerie.id !== serieId);
        return level.exercisesSeries.length > 0;
    });
}

onMounted(() => {
    fetchFavorites();
});
</script>