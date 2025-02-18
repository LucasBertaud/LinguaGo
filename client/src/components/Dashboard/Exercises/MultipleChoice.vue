<template>
    <div v-for="choice in currentExercise.choices" :key="choice">
        <input type="radio" :id="choice" :value="choice" :checked="choice === userAnswer" @change="updateAnswer(choice)" />
        <label :for="choice" class="ml-2">{{ choice }}</label>
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