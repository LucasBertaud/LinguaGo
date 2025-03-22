<template>
    <div class="w-full">
        <apexchart :type="type" :height="height" :options="options" :series="series"></apexchart>
    </div>
</template>

<script setup lang="ts">
defineProps<{
    options: Record<string, any>;
    series: Array<Record<string, any>> | number[];
    type: string;
    height?: string;
    width?: string;
}>();
</script>