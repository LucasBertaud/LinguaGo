<template>
    <div class="mt-6">
        <router-link :to="{ name: 'TalkSerie', params: { serieId: serie.id } }" 
            active-class="[&>div]:after:opacity-25"
            class="group relative">
            <div class="flex flex-row items-center after:transition-all after:content-[''] after:block after:w-[calc(100%+2rem)] after:rounded-xl after:h-[calc(100%+1rem)] after:left-1/2 after:top-1/2 after:-translate-x-1/2 after:-translate-y-1/2 after:absolute after:opacity-0 group-hover:after:opacity-25 after:bg-gray-200">
                <div class="flex flex-col mr-4 flex-1">
                    <p class="text-base text-gray-500 font-semibold">{{ serie.title }}</p>
                    <p class="text-gray-400 line-clamp-2 text-sm">{{ serie.description }}</p>
                </div>
                <div class="relative h-10 w-auto">
                    <svg class="size-full -rotate-90" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg">
                        <!-- Background Circle -->
                        <circle cx="18" cy="18" r="16" fill="none" class="stroke-current text-gray-200" stroke-width="4"></circle>
                        <!-- Progress Circle -->
                        <circle cx="18" cy="18" r="16" fill="none" class="stroke-current" :class="percentageCompleted == 100 ? 'text-secondary' : 'text-primary'" stroke-width="4" stroke-dasharray="100" :stroke-dashoffset="100 - percentageCompleted" stroke-linecap="round"></circle>
                    </svg>
                </div>
            </div>
        </router-link>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import ExercisesSerie from '../../../interface/exercises-serie.interface';
import { getPercentageCompleted } from '../../../utils/exercises.utils';
interface Props {
    serie: ExercisesSerie;
}

const { serie } = defineProps<Props>();

const percentageCompleted = ref<number>(0);

onMounted(async () => {
    percentageCompleted.value = await getPercentageCompleted(serie); 
});
</script>