<template>
    <Title title="S'exercer" subtitle="Exercez-vous à votre rythme et progressez dans votre apprentissage." />
    <section class="text-gray-600 body-font">
        <div class="container py-24 mx-auto flex flex-wrap flex-col pt-4">
            <div class="flex mx-auto flex-wrap mb-6">
                <router-link 
                    v-for="level in levels" 
                    :key="level.id"
                    :to="{
                        name: 'LevelDetail',
                        params: { levelTitle: level.title },
                    }"
                    class="sm:px-6 py-3 w-1/2 sm:w-auto justify-center sm:justify-start border-b-2 title-font font-medium inline-flex items-center leading-none border-gray-200 hover:text-gray-900 tracking-wider"
                    active-class="rounded-t bg-gray-100 !border-primary !text-primary">
                    {{ level.title }} ({{ level.subtitle }})
                </router-link>
            </div>
            <div v-if="levels.length > 0" class="flex flex-col text-center w-full">
                <router-view></router-view>
            </div>
        </div>
    </section>
    <LoadingSpinner v-if="isLoading" />
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import Title from '../../components/Dashboard/Layout/Title.vue';
import Database from '../../utils/database.utils';
import type Level from '../../interface/level.interface';
import LoadingSpinner from '../../components/LoadingSpinner.vue';

const levels = ref<Level[]>([]);
const isLoading = ref(false);

const fetchLevels = async () => {
    try {
        isLoading.value = true;
        const response = await Database.getAll('level');
        levels.value = response.map((level: Level) => {
                return level;
        });
        levels.value.sort((a, b) => a.title > b.title ? 1 : -1);
    } catch (error) {
        console.error('Erreur lors de la récupération des niveaux:', error);
    } finally {
        isLoading.value = false;
    }
};

onMounted(() => {
    fetchLevels();
});
</script>