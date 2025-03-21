<template>
  <Title
    title="S'entraîner à parler"
    subtitle="Entraînez-vous à parler et perfectionnez votre prononciation."
  />
  <section class="text-gray-600 body-font">
    <div class="flex sm:flex-row ml-4 mb-8 flex-wrap flex-col">
      <router-link
        class="mr-8 text-xl font-bold text-gray-300 hover:text-gray-800 text-nowrap relative"
        active-class="text-gray-500 items-center hover:!text-gray-500 before:content-[''] before:w-2 before:h-2 before:absolute before:left before:bg-gray-500 before:rounded-full before:top-1/2 before:-translate-y-1/2 before:-translate-x-3.5"
        v-for="level in levels"
        :key="level.id"
        :to="{ name: 'TalkLevelDetail', params: { levelTitle: level.title } }"
      >
        <span class="mr-1">{{ level.title }}</span>
        <span class="text-base">({{ level.subtitle }})</span>
      </router-link>
    </div>
    <router-view></router-view>
  </section>
  <LoadingSpinner v-if="isLoading" />
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import Title from "../../../components/Dashboard/Layout/Title.vue";
import { Database } from "../../../utils/database.utils";
import type Level from "../../../interface/level.interface";
import LoadingSpinner from "../../../components/LoadingSpinner.vue";
import { networkObserver } from "../../../services/network-observer";

const levels = ref<Level[]>([]);
const isLoading = ref(false);

const fetchLevels = async () => {
  try {
    isLoading.value = true;
    const { data } = await Database.get("level");
    levels.value = data.map((level: Level) => {
      return level;
    });
    levels.value.sort((a, b) => (a.title > b.title ? 1 : -1));
  } catch (error) {
    console.error("Erreur lors de la récupération des niveaux:", error);
  } finally {
    isLoading.value = false;
  }
};

onMounted(() => {
  if (!networkObserver.isOffline()) {
    fetchLevels();
  }
});
</script>
