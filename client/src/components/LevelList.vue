<template>
    <div>
        <h2 class="text-2xl font-bold">Niveaux</h2>
        <ul>
            <li v-for="level in levels" :key="level.id">
                <router-link :to="{ name: 'Exercises', params: { levelId: level.id } }">
                    {{ level.name }}
                </router-link>
            </li>
        </ul>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const levels = ref([
    { id: 1, name: 'Débutant' },
    { id: 2, name: 'Intermédiaire' },
    { id: 3, name: 'Avancé' }
]);
</script>