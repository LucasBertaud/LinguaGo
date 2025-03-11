<template>
    <div class="flex flex-col row-span-3 bg-white shadow rounded-lg">
        <div class="px-6 py-5 font-semibold border-b border-gray-100">
            <p>Séries complétés par niveau</p>
        </div>
        <div class="p-4 flex-grow">
            <div v-if="seriesCompletedStats && !isNoSeriesCompleted" class="flex items-center justify-center h-full text-gray-400 text-3xl font-semibold bg-gray-100 border-2 border-gray-200 border-dashed rounded-md">
                <Chart
                type="pie"
                :options="{
                    chart: {
                        toolbar: {
                            show: false,
                        },
                    },
                    labels: levels,
                }"
                :series="seriesCompletedStats"
                />
            </div>
            <p v-else class="text-center italic h-full content-center"> Aucune série complétée </p>
        </div>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { Database } from '../../../utils/database.utils';
import Chart from '../../Chart.vue';

const seriesCompletedStats = ref<number[]>();
const isNoSeriesCompleted = ref<boolean>(true);

const levels = ['A1', 'A2', 'B1', 'B2', 'C1'];

const fetchSeriesCompletedStats = async () => {
    try {
        const response = await Database.get('user-completed-exercises-serie/user');
        const filterResponse: number[] = [];
        for (const level of levels) {
            filterResponse.push(response.data.filter((serie: any) => serie.exercisesSerie.level.title === level).length);
        }
        seriesCompletedStats.value = filterResponse;
        isNoSeriesCompleted.value = response.data.length === 0;
    } catch (error) {
        console.error(error);
    }
}

onMounted(() => {
    fetchSeriesCompletedStats();
});
</script>