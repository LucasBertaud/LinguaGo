<template>
    <input type="text" v-model="localAnswer" @input="updateAnswer" class="border p-2 w-full" />
</template>

<script setup lang="ts">
import { ref } from 'vue';

const emit = defineEmits(['update:userAnswer']);

const localAnswer = ref('');

const updateAnswer = () => {
    emit('update:userAnswer', localAnswer.value);
};
</script>