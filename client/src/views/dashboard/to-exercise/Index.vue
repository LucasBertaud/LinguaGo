<template>
  <Title
    title="S'exercer"
    subtitle="Exercez-vous à votre rythme et progressez dans votre apprentissage."
  />
  <section class="text-gray-600 body-font">
    <div
      class="container py-24 mx-auto flex flex-wrap flex-col pt-4"
      v-if="!networkObserver.isOffline()"
    >
      <div class="flex mx-auto flex-wrap mb-6">
        <router-link
          v-for="level in levels"
          :key="level.id"
          :to="{
            name: 'LevelDetail',
            params: { levelTitle: level.title },
          }"
          class="sm:px-6 py-3 w-1/2 sm:w-auto justify-center sm:justify-start border-b-2 title-font font-medium inline-flex items-center leading-none border-gray-200 hover:text-gray-900 tracking-wider"
          active-class="rounded-t bg-gray-100 !border-primary !text-primary"
        >
          {{ level.title }} ({{ level.subtitle }})
        </router-link>
      </div>
      <div class="flex flex-col text-center w-full">
        <router-view></router-view>
      </div>
    </div>
    <div v-else>
      <div
        class="flex items-start p-4 mb-4 text-sm text-red-800 rounded-lg bg-red-50 w-full sm:w-110"
        role="alert"
      >
        <svg
          class="shrink-0 inline w-4 h-4 me-3"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Info</span>
        <div>
          <span class="font-medium">Vous êtes hors-ligne !</span> Veuillez vous
          connecter à internet pour accéder aux exercices.
        </div>
      </div>
    </div>
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
