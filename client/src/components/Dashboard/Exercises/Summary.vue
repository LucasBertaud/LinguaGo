<template>
    <div class="container mx-auto p-4 bg-white rounded-lg shadow-lg max-w-4xl">
        <p class="text-lg mb-4">Vous avez fait tous les exercices pour cette série.</p>
        <p class="text-lg font-semibold mb-2">Récapitulatif :</p>
        <div class="grid grid-cols-1 gap-4">
            <div v-for="exercise in completedExercises" :key="exercise.id" class="p-4 bg-gray-100 rounded-lg shadow transform transition-transform hover:scale-105">
                <div class="flex items-center mb-2">
                    <div class="flex-shrink-0 w-10 h-10 bg-primary text-white rounded-full flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                    </div>
                    <p class="ml-4 font-semibold text-lg">{{ exercise.question }}</p>
                </div>
                <p class="text-left">Réponse : <span class="font-semibold text-secondary">{{ exercise.answer }}</span></p>
            </div>
        </div>
        <p class="mt-4 text-lg font-semibold">Nombre de bonnes réponses : <span class="text-green-500">{{ correctAnswersCount }}</span> / <span class="text-gray-500">{{ totalExercises }}</span></p>
        <p v-if="allCorrect" class="mt-4 text-lg font-semibold text-green-500">Félicitations ! Vous avez répondu correctement à toutes les questions !</p>
        <p v-else class="mt-4 text-lg font-semibold text-red-500">Vous n'avez pas répondu correctement à toutes les questions. Vous pouvez recommencer.</p>
        <button @click="goToExercises" class="mt-6 p-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition duration-300 cursor-pointer">Retour aux exercices</button>
    </div>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import type Exercise from '../../../interface/exercise.interface';
import confetti from 'canvas-confetti';
import Database from '../../../utils/database.utils';
import type UserCompletedExercisesSerie from '../../../interface/user-completed-exercises-serie.interface';
import { networkObserver } from '../../../services/network-observer';
import { methods, OfflineStorageService } from '../../../services/offline-storage.service';

const router = useRouter();
const route = useRoute();

const props = defineProps<{ completedExercises: Exercise[], totalExercises: number, serieId: number, userId: string }>();

const correctAnswersCount = computed(() => {
    return props.completedExercises.length;
});

const allCorrect = computed(() => {
    return correctAnswersCount.value === props.totalExercises;
});

const goToExercises = () => {
    router.push(`/dashboard/to-exercise/${route.params.levelTitle}`);
};

const stampInDatabase = async () => {
    try {
        if(networkObserver.isOffline){
            const data: object = {
                userId: props.userId,
                serieId: props.serieId,
            };
            OfflineStorageService.store("user-completed-exercises-serie", data, methods.POST);
            return;
        }
        await Database.create("user-completed-exercises-serie", {
            userId: props.userId,
            serieId: props.serieId,
        });
    } catch (error) {
        console.error(error);
    }
}

onMounted(() => {
    if (allCorrect.value) {
        confetti({
            particleCount: 100,
            spread: 70,
            origin: { x: 0.54, y: 0.5 }
        });

        const firstExercise: Exercise | undefined = props.completedExercises[0];
        if(!firstExercise) return;

        const UserCompletedExercisesSerie: UserCompletedExercisesSerie[] | undefined = firstExercise.serie?.completedUsers;
        if(UserCompletedExercisesSerie != undefined) {
            const isAlreadyCompleted = UserCompletedExercisesSerie.length > 0;
            if(!isAlreadyCompleted) stampInDatabase();
        }
    }
});
</script>