<template>
    <div class="relative">
        <span class="absolute inset-y-0 left-0 flex items-center pl-3">
            <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                <path fill-rule="evenodd"
                    d="M24 14h-2V8a6 6 0 0 0-12 0v6H8a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V16a2 2 0 0 0-2-2M12 8a4 4 0 0 1 8 0v6h-8Zm12 20H8V16h16Z" />
            </svg>
        </span>
        <input :value="modelValue" @input="$emit('update:modelValue', ($event.target as HTMLInputElement).value)"
            :id="id" :type="showPassword ? 'text' : 'password'" :placeholder="placeholder"
            class="w-full px-10 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary" />
        <button type="button" @click="togglePassword" class="absolute inset-y-0 right-0 flex items-center pr-3">
            <svg v-if="showPassword" class="h-5 w-5 text-gray-700" xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24">
                <path fill="currentColor"
                    d="M12 9a3 3 0 1 0 0 6a3 3 0 0 0 0-6zm0-4.5c5 0 9.27 3.11 11 7.5c-1.73 4.39-6 7.5-11 7.5S2.73 16.39 1 12c1.73-4.39 6-7.5 11-7.5zM3.18 12a9.821 9.821 0 0 0 17.64 0a9.821 9.821 0 0 0-17.64 0z" />
            </svg>
            <svg v-else class="h-5 w-5 text-gray-700" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path fill="currentColor"
                    d="M2 5.27L3.28 4L20 20.72L18.73 22l-3.08-3.08c-1.15.38-2.37.58-3.65.58c-5 0-9.27-3.11-11-7.5c.69-1.76 1.79-3.31 3.19-4.54L2 5.27M12 9a3 3 0 0 1 3 3a3 3 0 0 1-.17 1L11 9.17A3 3 0 0 1 12 9m0-4.5c5 0 9.27 3.11 11 7.5a11.79 11.79 0 0 1-4 5.19l-1.42-1.43A9.862 9.862 0 0 0 20.82 12A9.821 9.821 0 0 0 12 6.5c-1.09 0-2.16.18-3.16.5L7.3 5.47c1.44-.62 3.03-.97 4.7-.97M3.18 12A9.821 9.821 0 0 0 12 17.5c.69 0 1.37-.07 2-.21L11.72 15A3.064 3.064 0 0 1 9 12.28L5.6 8.87c-.99.85-1.82 1.91-2.42 3.13z" />
            </svg>
        </button>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

defineProps({
    modelValue: {
        type: String,
        required: true
    },
    id: {
        type: String,
        required: true
    },
    placeholder: {
        type: String,
        default: 'Mot de passe'
    }
});

defineEmits(['update:modelValue']);

const showPassword = ref(false);

const togglePassword = () => {
    showPassword.value = !showPassword.value;
};
</script>