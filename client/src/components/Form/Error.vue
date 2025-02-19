<template>
    <div v-if="error" class="text-red-600 text-xs mt-2">
        {{ error }}
    </div>
</template>

<script setup lang="ts">
defineProps<{
    error: string | null;
}>();
</script>