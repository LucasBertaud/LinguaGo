<template>
  <div
    class="flex flex-col md:col-span-2 md:row-span-2 bg-white shadow rounded-lg"
  >
    <div class="px-6 py-5 font-semibold border-b border-gray-100">
      <p>Le nombre d'exercises réussis par jour sur une semaine</p>
    </div>
    <div class="p-4 flex-grow">
      <div
        class="flex items-center justify-center h-full text-gray-400 text-3xl font-semibold bg-gray-100 border-2 border-gray-200 border-dashed rounded-md"
      >
        <Chart
          v-if="exercisesCompletedPerDaysStats"
          height="190"
          type="area"
          :options="{
            chart: {
              toolbar: {
                show: false,
              },
            },
            xaxis: {
              categories: days,
            },
            colors: ['#ffc503'],
          }"
          :series="[
            {
              name: 'Exercices complétés',
              data: exercisesCompletedPerDaysStats,
            },
          ]"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import { Database } from "../../../utils/database.utils";
import Chart from "../../Chart.vue";

const exercisesCompletedPerDaysStats = ref<number[]>();

const days = Array.from({ length: 7 }, (_, i) => {
  const date = new Date();
  date.setDate(date.getDate() - i);
  return date.toLocaleDateString("fr-FR", { month: "2-digit", day: "2-digit" });
}).reverse();

const fetchExercisesCompletedStats = async () => {
  try {
    const { data } = await Database.get("user-completed-exercise/one-week");
    const groupBy = (objectArray: any, key: any) => {
      return objectArray.reduce((rv: any, x: any) => {
        const dateKey = new Date(x[key]).toLocaleDateString("fr-FR", {
          month: "2-digit",
          day: "2-digit",
        });
        (rv[dateKey] = rv[dateKey] || []).push(x);
        return rv;
      }, {});
    };
    const groupByDay = groupBy(data, "completedAt");
    exercisesCompletedPerDaysStats.value = days.map((day) => {
      return groupByDay[day]?.length ?? 0;
    });
  } catch (error) {
    console.error(error);
  }
};

onMounted(() => {
  fetchExercisesCompletedStats();
});
</script>
