<template>
    <input type="text" v-model="localAnswer" @input="updateAnswer" class="border border-gray-300 p-3 w-full rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Tapez votre réponse ici..." />
</template>

<script setup lang="ts">
import { ref } from 'vue';

const emit = defineEmits(['update:userAnswer']);

const localAnswer = ref('');

const updateAnswer = () => {
    if(localAnswer.value === '') return;
    emit('update:userAnswer', localAnswer.value);
};
</script>