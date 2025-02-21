<template>
    <div v-for="choice in currentExercise.choices" :key="choice" class="mb-2">
        <input type="radio" :id="choice" :value="choice" :checked="choice === userAnswer" @change="updateAnswer(choice)" class="hidden peer" />
        <label :for="choice" class="inline-flex items-center justify-between w-full p-3 text-gray-500 bg-white border border-gray-200 rounded-lg cursor-pointer peer-checked:border-primary peer-checked:text-primary hover:bg-gray-100">
            <span>{{ choice }}</span>
        </label>
    </div>
</template>

<script setup lang="ts">
import type Exercise from '../../../interface/exercise.interface';

defineProps<{ 
    currentExercise: Exercise,
    userAnswer: string | null 
}>();

const emit = defineEmits(['update:userAnswer']);

const updateAnswer = (choice: string) => {
    emit('update:userAnswer', choice);
};
</script>