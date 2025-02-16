<template>
    <router-link 
        :to="link" 
        class="text-white flex items-center gap-3 rounded-lg px-4 py-2.5 font-semibold hover:bg-white hover:text-slate-600 group hover:shadow-xs hover:shadow-slate-300/50 active:bg-white/75 active:text-slate-800 active:shadow-slate-300/10"
        active-class="bg-white !text-slate-600 shadow-slate-300/50 shadow-xs [&>i>svg>*]:!fill-slate-400 [&>i>svg]:!fill-slate-400">
        <i v-html="svgContent" class="group-hover:[&>svg>*]:fill-slate-600 [&>svg]:w-4 [&>svg]:h-4 [&>svg>*]:fill-white [&>svg]:fill-white"></i>
        <span>{{ label }}</span>
    </router-link>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { loadSvg } from '../../../../utils/loadSvg';

interface Props {
    link: string;
    label: string;
    icon?: string;
}

const svgContent = ref<string | null>(null);
const props = defineProps<Props>();

const icon = computed(() => props.icon);

onMounted(async () => {
    if(icon.value){
        svgContent.value = await loadSvg(`/assets/images/icons/${icon.value}.svg`);
    }
});

</script>