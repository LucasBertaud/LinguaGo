<template>
    <div>
        <h1 class="text-2xl font-bold mb-4">Exercice pour la série {{ serieTitle }}</h1>
        <div v-if="allExercisesCompleted">
            <p>Vous avez terminé tous les exercices pour cette série.</p>
            <p>Récapitulatif :</p>
            <ul>
                <li v-for="exercise in completedExercises" :key="exercise.id">
                    {{ exercise.question }} - Réponse : {{ exercise.answer }}
                </li>
            </ul>
            <button @click="goToExercises" class="mt-4 p-2 bg-blue-500 text-white rounded">Retour aux exercices</button>
        </div>
        <div v-else-if="currentExercise">
            <div class="mb-4 p-4 border rounded">
                <h2 class="text-xl font-semibold">{{ currentExercise.question }}</h2>
                <div v-if="currentExercise.type === 'MULTIPLE_CHOICE'">
                    <div v-for="choice in currentExercise.choices" :key="choice">
                        <input type="radio" :value="choice" v-model="userAnswer" /> {{ choice }}
                    </div>
                </div>
                <div v-else-if="currentExercise.type === 'TRANSLATION'">
                    <input type="text" v-model="userAnswer" class="border p-2 w-full" />
                </div>
                <div v-else-if="currentExercise.type === 'TRUE_FALSE'">
                    <input type="radio" value="True" v-model="userAnswer" /> True
                    <input type="radio" value="False" v-model="userAnswer" /> False
                </div>
                <button @click="checkAnswer" class="mt-4 p-2 bg-blue-500 text-white rounded">Vérifier</button>
                <p v-if="feedback" :class="{ 'text-green-500': isCorrect, 'text-red-500': !isCorrect }">{{ feedback }}</p>
            </div>
            <button v-if="answered" @click="nextExercise"
                class="mt-4 p-2 bg-blue-500 text-white rounded">Suivant</button>
        </div>
        <div v-else>
            <p>Aucun exercice trouvé pour cette série.</p>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useStore } from 'vuex';
import Database from '../../utils/database';
import type Exercise from '../../interface/exercise.interface';

const route = useRoute();
const router = useRouter();
const store = useStore();
const serieId = parseInt(route.params.serieId as string, 10);
const serieTitle = route.params.serieTitle as string;
const exercises = ref<Exercise[]>([]);
const completedExercises = ref<Exercise[]>([]);
const currentExerciseIndex = ref(0);
const userAnswer = ref<string | null>(null);
const feedback = ref<string | null>(null);
const isCorrect = ref<boolean>(false);
const answered = ref<boolean>(false);
const allExercisesCompleted = ref<boolean>(false);
const userId = store.getters.getUser.id;

const fetchExercises = async () => {
    try {
        const response = await Database.getAll(`exercise/serie/${serieId}`);
        exercises.value = response;
        completedExercises.value = response.filter((exercise: Exercise) => exercise.usersCompleted.length > 0);
        if (exercises.value.length === 0 || completedExercises.value.length === exercises.value.length) {
            allExercisesCompleted.value = true;
        }
    } catch (error) {
        console.error('Erreur lors de la récupération des exercices:', error);
    }
};

const checkAnswer = async () => {
    const answer = userAnswer.value?.toLowerCase().replace(/[.,!?;:'"]/g, '').trim();
    if (answer === currentExercise.value.answer) {
        feedback.value = 'Bonne réponse !';
        isCorrect.value = true;
        await markExerciseAsCompleted();
    } else {
        feedback.value = 'Mauvaise réponse. La bonne réponse est : ' + currentExercise.value.answer;
        isCorrect.value = false;
        await markExerciseAsFailed();
    }
    answered.value = true;
};

const markExerciseAsCompleted = async () => {
    const exerciseId = currentExercise.value.id;
    
    if(completedExercises.value.find((exercise) => exercise.id === exerciseId)) {
        return;
    }
    try {
        await Database.create('user-completed-exercise', {
            userId,
            exerciseId,
            serieId
        });
        completedExercises.value.push(currentExercise.value);
    } catch (error) {
        console.error('Erreur lors de l\'enregistrement de la complétion de l\'exercice:', error);
    }
};

const markExerciseAsFailed = async () => {
    const exerciseId = currentExercise.value.id;
    
    if(!completedExercises.value.find((exercise) => exercise.id === exerciseId)) {
        return;
    }

    try {
        await Database.delete(`user-completed-exercise/${userId}/${exerciseId}`);
    } catch (error) {
        console.error('Erreur lors de l\'enregistrement de la complétion de l\'exercice:', error);
    }
}

const nextExercise = () => {
    if (currentExerciseIndex.value < exercises.value.length - 1) {
        currentExerciseIndex.value++;
    } else {
        allExercisesCompleted.value = true; // Marquer tous les exercices comme complétés
    }
    userAnswer.value = null;
    feedback.value = null;
    answered.value = false;
};

const goToExercises = () => {
    router.push(`/dashboard/to-exercise/${route.params.levelTitle}`);
};

onMounted(() => {
    fetchExercises();
});

const currentExercise = computed(() => exercises.value[currentExerciseIndex.value]);
</script>