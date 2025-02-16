<template>
    <Title title="S'exercer" subtitle="Exercez-vous à votre rythme et progressez dans votre apprentissage." />
    <section class="text-gray-600 body-font">
        <div class="container py-24 mx-auto flex flex-wrap flex-col pt-4">
            <div class="flex mx-auto flex-wrap mb-6">
                <router-link 
                    v-for="level in levels" 
                    :key="level.id"
                    :to="level.title"
                    class="sm:px-6 py-3 w-1/2 sm:w-auto justify-center sm:justify-start border-b-2 title-font font-medium inline-flex items-center leading-none border-gray-200 hover:text-gray-900 tracking-wider"
                    active-class="rounded-t bg-gray-100 !border-primary !text-primary">
                    {{ level.title }} ({{ level.subtitle }})
                </router-link>
            </div>
            <div class="flex flex-col text-center w-full">
                <router-view></router-view>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import Title from '../../components/Dashboard/Layout/Title.vue';
import Database from '../../utils/database';
import type Level from '../../interface/level.interface';

const levels = ref<Level[]>([]);

const fetchLevels = async () => {
    const response = Database.getAll('level')
    response.then((data) => {
        levels.value = data.map((level: Level) => {
            return level;
        });
        levels.value.sort((a, b) => a.title > b.title ? 1 : -1);
    }).catch((error) => {
        console.error(error);
    });
};

onMounted(() => {
    fetchLevels();
});
</script>