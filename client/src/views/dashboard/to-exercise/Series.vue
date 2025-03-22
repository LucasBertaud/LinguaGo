<template>
  <div v-if="!isLoading" class="flex flex-wrap m-4 justify-center">
    <div
      v-for="exercisesSerie in level?.exercisesSeries"
      :key="exercisesSerie.id"
      class="lg:w-1/2 xl:w-1/3 w-full"
    >
      <ExercisesSerieCard :exercises-serie="exercisesSerie" />
    </div>
  </div>
  <LoadingSpinner v-if="isLoading" />
</template>

<script setup lang="ts">
import ExercisesSerieCard from "../../../components/Dashboard/Card/ExercisesSerieCard.vue";
import { onMounted, ref, watch } from "vue";
import { useRoute } from "vue-router";
import { Database } from "../../../utils/database.utils";
import type Level from "../../../interface/level.interface";
import LoadingSpinner from "../../../components/LoadingSpinner.vue";

const props = defineProps<{
  levelTitle: string;
}>();
const route = useRoute();
const level = ref<Level>();
const isLoading = ref(false);

const fetchLevel = async () => {
  try {
    isLoading.value = true;
    const { data } = await Database.get("level/title/" + props.levelTitle);
    level.value = data;
  } catch (error) {
    console.error("Erreur lors du chargement du niveau:", error);
  } finally {
    isLoading.value = false;
  }
};

watch(
  () => route.query,
  () => {
    fetchLevel();
  }
);

onMounted(() => {
  fetchLevel();
});
</script>
