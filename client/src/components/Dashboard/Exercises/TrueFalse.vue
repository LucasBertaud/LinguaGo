<template>
    <div>
        <input type="radio" id="true" value="True" v-model="localAnswer" @input="updateAnswer" />
        <label for="true" class="ml-2">True</label>
    </div>
    <div>
        <input type="radio" id="false" value="False" v-model="localAnswer" @input="updateAnswer" />
        <label for="false" class="ml-2">False</label>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const emit = defineEmits(['update:userAnswer']);

const localAnswer = ref('');

const updateAnswer = () => {
    emit('update:userAnswer', localAnswer.value);
};</script>