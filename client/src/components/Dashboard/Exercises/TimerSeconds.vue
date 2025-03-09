<template>
    <p class="w-15" :class="colorTimer[color].text + ' ' + customClass">{{ seconds }}s</p>
</template>

<script setup lang="ts">
import { onMounted, onUnmounted, ref } from 'vue';
import Database from '../../../utils/database.utils';

interface Props {
    color?: string;
    customClass?: string;
}

const { 
    color = 'primary', 
    customClass = 'font-semibold text-base'
} = defineProps<Props>()

const colorTimer: Record<string, { text: string}> = {
    primary: {
        text: 'text-primary'
    },
    secondary: {
        text: 'text-secondary'
    },
    gray: {
        text: 'text-gray-600'
    }
}

const seconds = ref<number>(0);
let timer: number | null = null;

const startTimer = async (): Promise<void> => {
    if(!timer) {
        timer = setInterval(() => {
            seconds.value++;
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
    if(seconds.value > 5){
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