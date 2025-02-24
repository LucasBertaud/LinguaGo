<template>
    <div class="container mx-auto p-4" v-if="exercisesFetched">
        <div class="flex flex-row items-center mb-6 justify-between mx-4" :class="{ 'justify-center': allExercisesCompleted }">
            <h2 class="text-2xl font-bold text-primary">
                {{ allExercisesCompleted ? 'Résumé des exercices' : `Exercice ${currentExerciseIndex + 1}/${exercises.length}` }}
            </h2>
            <Timer v-if="!allExercisesCompleted" />
        </div>
        <div v-if="exercises.length === 0">
            <p class="text-gray-500">Aucun exercice trouvé pour cette série.</p>
        </div>
        <div v-else-if="allExercisesCompleted">
            <Summary :completed-exercises="completedExercises" :total-exercises="exercises.length"
            :serie-id="serieId"
            :user-id="userId" />
        </div>
        <div v-else-if="currentExercise">
            <div class="mb-6 p-6 rounded-lg shadow-xl bg-white">
                <div class="flex flex-row">
                    <h3 class="text-1xl font-semibold mb-4">{{ currentExerciseIndex + 1 }}. {{ currentExercise.question }}</h3>
                </div>
                <div v-if="currentExercise.type === 'MULTIPLE_CHOICE'">
                    <MultipleChoice :current-exercise="currentExercise" :user-answer="userAnswer"
                        @update:userAnswer="userAnswer = $event" />
                </div>
                <div v-else-if="currentExercise.type === 'TRANSLATION'">
                    <Translation @update:user-answer="userAnswer = $event" />
                </div>
                <div v-else-if="currentExercise.type === 'TRUE_FALSE'">
                    <TrueFalse :user-answer="userAnswer" @update:user-answer="userAnswer = $event" />
                </div>
                <button @click="checkAnswer"
                    class="mt-4 p-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition duration-300 cursor-pointer">Vérifier</button>
            </div>
        </div>
    </div>
    <LoadingSpinner v-if="isLoading" />
</template>

<script setup lang="ts">
import Summary from '../../components/Dashboard/Exercises/Summary.vue';
import MultipleChoice from '../../components/Dashboard/Exercises/MultipleChoice.vue';
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import { useStore } from 'vuex';
import LoadingSpinner from '../../components/LoadingSpinner.vue';
import Database from '../../utils/database.utils';
import type Exercise from '../../interface/exercise.interface';
import Translation from '../../components/Dashboard/Exercises/Translation.vue';
import TrueFalse from '../../components/Dashboard/Exercises/TrueFalse.vue';
import Timer from '../../components/Dashboard/Exercises/Timer.vue';

const route = useRoute();
const store = useStore();
const isLoading = ref(false);
const serieId = parseInt(route.params.serieId as string, 10);
const exercises = ref<Exercise[]>([]);
const completedExercises = ref<Exercise[]>([]);
const currentExerciseIndex = ref(0);
const userAnswer = ref<string | null>(null);
const feedback = ref<string | null>(null);
const isCorrect = ref<boolean>(false);
const answered = ref<boolean>(false);
const allExercisesCompleted = ref<boolean>(false);
const userId = store.getters.getUser.id;
const exercisesFetched = ref<boolean>(false);

let pointsPerExo: number = 1;

const fetchExercises = async () => {
    try {
        isLoading.value = true;
        const response = await Database.getAll(`exercise/serie/${serieId}`);
        pointsPerExo = response[0].serie.level.pointsPerExo;
        exercises.value = response;
        completedExercises.value = response.filter((exercise: Exercise) => exercise.usersCompleted.length > 0);
        if (exercises.value.length === 0 || completedExercises.value.length === exercises.value.length) {
            allExercisesCompleted.value = true;
        }
        exercisesFetched.value = true;
    } catch (error) {
        console.error('Erreur lors de la récupération des exercices:', error);
    } finally {
        isLoading.value = false;
    }
};

const checkAnswer = async () => {
    const answer = userAnswer.value?.toLowerCase().replace(/[.,!?;:'"]/g, '').trim();
    const correctAnswer = currentExercise.value.answer.toLowerCase().replace(/[.,!?;:'"]/g, '').trim();
    if (answer === correctAnswer) {
        isCorrect.value = true;
        await markExerciseAsCompleted();
    } else {
        isCorrect.value = false;
        await markExerciseAsFailed();
    }
    answered.value = true;
    nextExercise();
};

const markExerciseAsCompleted = async () => {
    const exerciseId = currentExercise.value.id;
    
    if (completedExercises.value.find((exercise) => exercise.id === exerciseId)) {
        return;
    }
    try {
        isLoading.value = true;
        await Database.create('user-completed-exercise', {
            userId,
            exerciseId,
            serieId,
            pointsWon: pointsPerExo,
        });
        completedExercises.value.push(currentExercise.value);
    } catch (error) {
        console.error('Erreur lors de l\'enregistrement de la complétion de l\'exercice:', error);
    } finally {
        isLoading.value = false;
    }
};

const markExerciseAsFailed = async () => {
    const exerciseId = currentExercise.value.id;

    incrementFailedExercises();

    if (!completedExercises.value.find((exercise) => exercise.id === exerciseId)) {
        return;
    }

    try {
        isLoading.value = true;
        await Database.delete(`user-completed-exercise/${userId}/${exerciseId}`);
    } catch (error) {
        console.error('Erreur lors de l\'enregistrement de la complétion de l\'exercice:', error);
    } finally {
        isLoading.value = false;
    }
}

const incrementFailedExercises = async () => {
    try {
        isLoading.value = true;
        await Database.patch('user-stats/failed-exercises');
    } catch (error) {
        console.error('Erreur lors de l\'enregistrement de l\'échec de l\'exercice:', error);
    } finally {
        isLoading.value = false;
    }
};

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

onMounted(() => {
    fetchExercises();
});

const currentExercise = computed(() => exercises.value[currentExerciseIndex.value]);
</script>