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
import Summary from '../../../components/Dashboard/Exercises/Summary.vue';
import MultipleChoice from '../../../components/Dashboard/Exercises/MultipleChoice.vue';
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import { useStore } from 'vuex';
import LoadingSpinner from '../../../components/LoadingSpinner.vue';
import type Exercise from '../../../interface/exercise.interface';
import Translation from '../../../components/Dashboard/Exercises/Translation.vue';
import TrueFalse from '../../../components/Dashboard/Exercises/TrueFalse.vue';
import Timer from '../../../components/Dashboard/Exercises/TimerDisplay.vue';
import { ExercisesService } from '../../../services/exercises.service';
import { translationCheck } from '../../../services/ai.services';

defineProps<{
    levelTitle: string;
    serieId: string;
}>();
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
const exercisesService = ref<ExercisesService | null>(null);

const fetchExercises = async () => {
    isLoading.value = true;
    exercisesService.value = new ExercisesService(userId, serieId);
    exercises.value = await exercisesService.value.fetchExercises()
    .then((response: Exercise[]) => {
        completedExercises.value = response.filter((exercise: Exercise) => exercise.usersCompleted.length > 0);
        return response;
    })
    .finally(() => {
        exercisesFetched.value = true;
        isLoading.value = false;
    });

    if (exercises.value.length === 0 || completedExercises.value.length === exercises.value.length) {
        allExercisesCompleted.value = true;
    }
};

const checkAnswer = async () => {
    const answer = userAnswer.value?.toLowerCase().replace(/[.,!?;:'"]/g, '').trim();
    const correctAnswer = currentExercise.value.answer.toLowerCase().replace(/[.,!?;:'"]/g, '').trim();

    
    if (answer === correctAnswer) {
        isCorrect.value = true;
        await markExerciseAsCompleted();
    } else {
        if(currentExercise.value.type === "TRANSLATION"){
            const check = await translationCheck([currentExercise.value.question, answer]);
            if(check == "accept"){
                isCorrect.value = true;
                await markExerciseAsCompleted();
            } else {
                isCorrect.value = false;
                await markExerciseAsFailed();
            }
        } else {
            isCorrect.value = false;
            await markExerciseAsFailed();
        }
    }

    answered.value = true;
    nextExercise();
};

const markExerciseAsCompleted = async () => {
    isLoading.value = true;
    exercisesService.value.markExerciseAsCompleted(currentExercise.value, completedExercises.value)
    .then(() => {
        if(!completedExercises.value.includes(currentExercise.value)){
            completedExercises.value.push(currentExercise.value);
        }
    })
    .finally(() => {
        isLoading.value = false;
    });
};

const markExerciseAsFailed = async () => {
    isLoading.value = true;
    exercisesService.value.markExerciseAsFailed(currentExercise.value, completedExercises.value)
    .then(() => {
        if(completedExercises.value.includes(currentExercise.value)){
            completedExercises.value = completedExercises.value.filter((exercise: Exercise) => exercise.id !== currentExercise.value.id);
        }
    })
    .finally(() => {
        isLoading.value = false;
    });
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

onMounted(() => {
    fetchExercises();
});

const currentExercise = computed(() => exercises.value[currentExerciseIndex.value]);
</script>