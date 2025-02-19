<template>
    <section class="flex flex-wrap m-4 justify-center">
        <div v-for="exercisesSerie in level?.exercisesSeries" :key="exercisesSerie.id" class="lg:w-1/2 xl:w-1/3 w-full">
            <ExercisesSerieCard :exercises-serie="exercisesSerie" />
        </div>
    </section>
</template>

<script setup lang="ts">
import ExercisesSerieCard from '../../components/Dashboard/Card/ExercisesSerieCard.vue';
import { onMounted, ref, watch } from 'vue';
import { useRoute } from 'vue-router';
import Database from '../../utils/database';
import type Level from '../../interface/level.interface';

const props = defineProps<{
    levelTitle: string;
}>();
const route = useRoute();
const level = ref<Level>();

const fetchLevel = async () => {
    const response = Database.getOne('level/title', props.levelTitle);
    response.then((data) => {
        level.value = data;
    }).catch((error) => {
        console.error(error);
    });
};

watch(() => route.query, () => {
    fetchLevel();
});

onMounted(() => {
    fetchLevel();
});

</script>