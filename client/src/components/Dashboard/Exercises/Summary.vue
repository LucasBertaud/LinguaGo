<template>
    <p>Vous avez terminé tous les exercices pour cette série.</p>
    <p>Récapitulatif :</p>
    <ul>
        <li v-for="exercise in completedExercises" :key="exercise.id">
            {{ exercise.question }} - Réponse : {{ exercise.answer }}
        </li>
    </ul>
    <button @click="goToExercises" class="mt-4 p-2 bg-blue-500 text-white rounded">Retour aux exercices</button>
</template>

<script setup lang="ts">
import { useRoute, useRouter } from 'vue-router';
import type Exercise from '../../../interface/exercise.interface';

const router = useRouter();
const route = useRoute();

defineProps<{ completedExercises: Exercise[] }>();

const goToExercises = () => {
    router.push(`/dashboard/to-exercise/${route.params.levelTitle}`);
};
</script>