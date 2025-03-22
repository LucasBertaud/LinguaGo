<template>
    <div class="flex flex-col space-y-4">
        <div class="flex items-center">
            <input type="radio" id="true" value="True" v-model="localAnswer" @input="updateAnswer" class="hidden peer" />
            <label for="true" class="ml-2 inline-flex items-center justify-between w-full p-3 text-gray-500 bg-white border border-gray-200 rounded-lg cursor-pointer peer-checked:border-primary peer-checked:text-primary hover:bg-gray-100">
                <span>True</span>
            </label>
        </div>
        <div class="flex items-center">
            <input type="radio" id="false" value="False" v-model="localAnswer" @input="updateAnswer" class="hidden peer" />
            <label for="false" class="ml-2 inline-flex items-center justify-between w-full p-3 text-gray-500 bg-white border border-gray-200 rounded-lg cursor-pointer peer-checked:border-primary peer-checked:text-primary hover:bg-gray-100">
                <span>False</span>
            </label>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';

const emit = defineEmits(['update:userAnswer']);
const props = defineProps<{ userAnswer: string | null }>();

const localAnswer = ref(props.userAnswer || '');

watch(localAnswer, (newValue) => {
    emit('update:userAnswer', newValue);
});

const updateAnswer = () => {
    emit('update:userAnswer', localAnswer.value);
};
</script>
