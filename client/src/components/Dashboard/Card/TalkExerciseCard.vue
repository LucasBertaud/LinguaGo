<template>
    <div id="talk-card" class="rounded-b-4xl rounded-t-4xl shadow-lg overflow-hidden">
        <div id="header-talk-card" class="bg-gray-100 p-8 pb-0 flex-row relative">
            <div class="flex flex-col">
                <h2 class="text-black font-semibold text-xl">Exercise {{ currentExerciseIndex + 1 }}/{{ serie.exercises.length }}</h2>
                <p class="text-gray-600 text-sm mt-2 text-pretty">Répétez la phrase en anglais quand vous cliquerez sur le bouton démarrer :</p>
                <p class="text-black font-bold italic mb-4">"{{ currentExercise?.answer }}"</p>
            </div>
            <FavoriteButton :serie-id="serie.id" :user-favorite-serie="userFavoriteSerie" />
        </div>
        <div id="body-talk-card" class="bg-gray-100 p-8 rounded-b-4xl">
            <div class="flex flex-row items-center">
                <button 
                    class="bg-white w-16 h-16 flex justify-center items-center rounded-full group active:scale-95 hover:scale-110 cursor-pointer transition relative" 
                    @click="handlePlay"
                >
                    <Icon v-if="!isPlaying" svg-path="/assets/images/icons/play.svg" :options="{ dynamicClasses: '[&>svg]:w-6 [&>svg]:h-6 [&>svg]:fill-black' }" />
                    <Icon v-else svg-path="/assets/images/icons/stop.svg" :options="{ dynamicClasses: '[&>svg]:w-7 [&>svg]:h-7 [&>svg]:fill-black' }" />
                    <Icon 
                        class="opacity-0 transition-all"
                        :class="isPlaying ? 'opacity-100' : 'opacity-0'"
                        svg-path="/assets/images/icons/spin.svg" :options="{
                            dynamicClasses: `
                                [&>svg]:absolute
                                [&>svg]:top-1/2
                                [&>svg]:left-1/2
                                [&>svg]:-translate-x-1/2
                                [&>svg]:-translate-y-1/2
                                [&>svg>path]:fill-white
                                [&>svg>path]:last:fill-secondary
                                [&>svg]:animate-spin
                                [&>svg]:w-28
                                [&>svg]:h-28
                            `
                        }" 
                    />
                </button>
                <p class="ml-8 text-gray-600 italic font-bold" v-if="answer">"{{ answer }}"</p>
            </div>
        </div>
        <div id="footer-talk-card" class="bg-white flex flex-row p-8">
            <div class="flex flex-row items-center mx-5 first:ml-0 last:mr-0">
                <div class="bg-secondary-light w-12 h-12 flex justify-center items-center rounded-2xl mr-4">
                    <Icon svg-path="/assets/images/icons/star.svg" :options="{ dynamicClasses: '[&>svg]:w-6 [&>svg]:h-6 [&>svg]:fill-secondary' }" />
                </div>
                <div>
                    <p class="font-bold text-xl">{{ pointsPerExo }}</p>
                    <h3 class="text-gray-400 font-semibold uppercase">Points</h3>
                </div>
            </div>
            <div class="flex flex-row items-center mx-5">
                <div class="bg-primary-light w-12 h-12 flex justify-center items-center rounded-2xl mr-4">
                    <Icon svg-path="/assets/images/icons/clock.svg" :options="{ dynamicClasses: '[&>svg]:w-6 [&>svg]:h-6 [&>svg]:stroke-primary' }" />
                </div>
                <div>
                    <TimerSeconds color="gray" custom-class="font-bold text-xl" />
                    <h3 class="text-gray-400 font-semibold uppercase">Temps</h3>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import Icon from '../../Icon.vue';
import FavoriteButton from '../Button/FavoriteButton.vue';
import ExercisesSerie from '../../../interface/exercises-serie.interface';
import UserFavoriteSerie from '../../../interface/user-favorite-serie.interface';
import store from '../../../store';
import TimerSeconds from '../Exercises/TimerSeconds.vue';
import Exercise from '../../../interface/exercise.interface';

const {serie, pointsPerExo} = defineProps<{
    serie: ExercisesSerie;
    pointsPerExo: number;
}>();

const userFavoriteSerie: UserFavoriteSerie | undefined = serie.favoriteUsers.find((favorite) => favorite.userId === store.getters.getUser.id && favorite.serieId === serie.id);

const isPlaying = ref(false);
const currentExercise = ref<Exercise>();
const currentExerciseIndex = ref<number>(0);
const answer = ref<string>('');
const recognition = ref(null);

const initVocal = () => {
    const SpeechRecognition = (window as any).SpeechRecognition || (window as any).webkitSpeechRecognition;

    const recognition = new SpeechRecognition();
    
    recognition.lang = 'en-US';
    recognition.interimResults = true;
    recognition.continuous = true;

    return recognition;
}
const handlePlay = () => {
    isPlaying.value = !isPlaying.value;
    if(isPlaying.value) {
        recognition.value.start();
        console.log('Recognition started');
        recognition.value.onresult = (e: any) => {
            const lastIndex: number = e.results.length - 1;
            const transcript: string = e.results[lastIndex][0].transcript;
            answer.value = transcript.toLowerCase().trim();
            isAnswerCorrect();
        }
        recognition.value.onend = () => {
            console.log('Recognition ended');
        }
    } else {
        recognition.value.stop();
    }
}

const isAnswerCorrect = async () => {
    const isCorrect: boolean = answer.value.includes(currentExercise.value.answer);
    if(isCorrect) {
        nextExercise();
    }
}

const nextExercise = () => {
    currentExerciseIndex.value++;
    currentExercise.value = 
    serie.exercises[currentExerciseIndex.value];
};

onMounted(() => {
    currentExercise.value = serie.exercises[currentExerciseIndex.value];
    recognition.value = initVocal();
});
</script>