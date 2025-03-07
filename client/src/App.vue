<template>
  <div v-if="$route.meta.dashboard !== true">
    <div class="bg-background min-h-screen">
      <router-view />
    </div>
  </div>

  <div class="flex bg-primary min-h-screen" v-if="$route.meta.dashboard === true">
    <AsideDashboard />
    <div class="flex-grow text-gray-800 flex flex-col overflow-hidden max-h-screen">
        <NavbarDashboard />
        <main class="p-6 sm:p-10 pb-0 sm:pb-0 space-y-6 rounded-tl-xl bg-white grow overflow-y-auto">
          <router-view />
        </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import NavbarDashboard from './components/Dashboard/Layout/NavbarDashboard.vue';
import AsideDashboard from './components/Dashboard/Layout/Aside/AsideDashboard.vue';
import {onMounted} from "vue";
import Clarity from "@microsoft/clarity";

defineOptions({
  name: 'App'
});

onMounted(() => {
  if (import.meta.env.VITE_CLARITY_PROJECT_ID) {
    Clarity.init(import.meta.env.VITE_CLARITY_PROJECT_ID);
    Clarity.consent();
  } else {
    console.warn('Clarity project ID not found. Please set VITE_CLARITY_PROJECT_ID in .env file');
  }
});
</script>
