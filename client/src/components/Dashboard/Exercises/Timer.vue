<template>
    <div class="bg-primary-light py-2 pl-6 pr-3 rounded-full flex flex-row items-center">
        <Icon 
        svg-path="/assets/images/icons/timer.svg"
        :options="{
            dynamicClasses: '[&>svg]:w-5.5 [&>svg]:h-auto [&>svg>*]:stroke-primary'
        }" />
        <p class="text-primary font-semibold w-15">{{ seconds }}s</p>
    </div>
</template>

<script setup lang="ts">
import { onMounted, onUnmounted, ref } from 'vue';
import Icon from '../../Icon.vue';
import Database from '../../../utils/database.utils';

const seconds = ref<number>(0);
let timer: number | null = null;

const startTimer = async (): Promise<void> => {
    if(!timer) {
        timer = setInterval(() => {
            seconds.value++;
            console.log('Timer:', seconds.value);
        }, 1000);
    }
}

const stopTimer = async (): Promise<void> => {
    if(timer) {
        clearInterval(timer);
        timer = null;
        saveTimer();
    }
}

const saveTimer = async (): Promise<void> => {
    if(seconds.value > 10){
        Database.patch('user-stats/time-spent-on-exercises', { timeSpent: seconds.value });
    }
}

onMounted(() => {
    startTimer();
})

onUnmounted(() => {
    stopTimer();
})
</script>