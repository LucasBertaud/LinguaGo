<template>
    <i :class="options?.dynamicClasses" v-html="svg"></i>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { loadSvg } from '../utils/loadSvg.utils';

interface Props {
    svgPath: string;
    options?: {
        dynamicClasses?: string;
    }
}

const props = defineProps<Props>();
const svg = ref<string | null>(null);

onMounted(async () => {
  svg.value = await loadSvg(props.svgPath);
});
</script>