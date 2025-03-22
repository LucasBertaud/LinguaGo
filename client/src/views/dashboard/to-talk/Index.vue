<template>
  <Title
    title="S'entraîner à parler"
    subtitle="Entraînez-vous à parler et perfectionnez votre prononciation."
  />
  <section class="text-gray-600 body-font">
    <div v-if="isSpeechAPIAvailable">
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
    </div>
    <div v-else>
      <div
        class="flex p-4 mb-4 text-sm text-red-800 rounded-lg bg-red-50 w-full sm:w-110"
        role="alert"
      >
        <svg
          class="shrink-0 inline w-4 h-4 me-3 mt-[2px]"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Danger</span>
        <div>
          <span class="font-medium"
            >Votre navigateur ne supporte pas la reconnaissance vocale.</span
          >
          <ul class="mt-1.5 list-disc list-inside">
            <li>Veuillez utiliser un navigateur compatible.</li>
            <li>(Google Chrome, Microsoft Edge, Safari, Opera)</li>
          </ul>
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
const isSpeechAPIAvailable = ref<boolean>(false);

const checkIfSpeechApiIsSupported = () => {
  if (!("webkitSpeechRecognition" in window || "SpeechRecognition" in window)) {
    return (isSpeechAPIAvailable.value = false);
  }
  if ("brave" in navigator) {
    return (isSpeechAPIAvailable.value = false);
  }
  if (/CriOS/.test(navigator.userAgent)) {
    return false;
  }
  return (isSpeechAPIAvailable.value = true);
};

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
  checkIfSpeechApiIsSupported();
});
</script>
