<template>
    <div>
        <h2 class="text-2xl font-bold">Exercices pour le niveau {{ levelId }}</h2>
        <ul>
            <li v-for="exercise in exercises" :key="exercise.id">
                {{ exercise.name }}
            </li>
        </ul>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const levelId = route.params.levelId;

const exercises = ref([
    { id: 1, name: 'Exercice 1' },
    { id: 2, name: 'Exercice 2' },
    { id: 3, name: 'Exercice 3' }
]);
</script>