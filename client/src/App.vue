<template>
  <div v-if="$route.meta.dashboard !== true">
    <div class="bg-background min-h-screen">
      <router-view />
    </div>
  </div>

  <div class="flex bg-primary min-h-screen" v-if="$route.meta.dashboard === true">
    <AsideDashboard />
    <div class="flex-grow text-gray-800 flex flex-col">
        <NavbarDashboard />
        <main class="p-6 sm:p-10 pb-0 sm:pb-0 space-y-6 rounded-tl-xl bg-white grow">
          <router-view />
        </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import NavbarDashboard from './components/Dashboard/Layout/NavbarDashboard.vue';
import AsideDashboard from './components/Dashboard/Layout/Aside/AsideDashboard.vue';

defineOptions({
  name: 'App'
});
</script>
