<template>
    <div class="flex flex-col space-y-6 md:space-y-0 md:flex-row justify-between">
        <div class="mr-6">
            <h1 class="text-4xl font-semibold mb-2">{{ title }}</h1>
            <p class="text-gray-600 ml-0.5">{{ subtitle }}</p>
        </div>
    </div>
</template>

<script setup lang="ts">
interface Props {
    title: string;
    subtitle?: string;
}

defineProps<Props>();
</script>