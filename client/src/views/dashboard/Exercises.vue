<template>
    <div>
        <h1 class="text-2xl font-bold mb-4">Exercice pour la série {{ serieTitle }}</h1>
        <div v-if="allExercisesCompleted">
            <Summary :completed-exercises="completedExercises" />
        </div>
        <div v-else-if="currentExercise">
            <div class="mb-4 p-4 border rounded">
                <h2 class="text-xl font-semibold">{{ currentExercise.question }}</h2>
                <div v-if="currentExercise.type === 'MULTIPLE_CHOICE'">
                    <MultipleChoice :current-exercise="currentExercise" :user-answer="userAnswer" @update:userAnswer="userAnswer = $event"/>
                </div>
                <div v-else-if="currentExercise.type === 'TRANSLATION'">
                    <Translation @update:user-answer="userAnswer = $event" />
                </div>
                <div v-else-if="currentExercise.type === 'TRUE_FALSE'">
                    <TrueFalse @update:user-answer="userAnswer = $event" />
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
import Summary from '../../components/Dashboard/Exercises/Summary.vue';
import MultipleChoice from '../../components/Dashboard/Exercises/MultipleChoice.vue';
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import { useStore } from 'vuex';
import Database from '../../utils/database';
import type Exercise from '../../interface/exercise.interface';
import Translation from '../../components/Dashboard/Exercises/Translation.vue';
import TrueFalse from '../../components/Dashboard/Exercises/TrueFalse.vue';

const route = useRoute();
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

onMounted(() => {
    fetchExercises();
});

const currentExercise = computed(() => exercises.value[currentExerciseIndex.value]);
</script>