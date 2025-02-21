<template>
    <aside id="page-sidebar" class="hidden sm:flex sm:flex-col bg-primary top-0 sticky max-h-screen" x-bind:class="{
    'ltr:-translate-x-full rtl:translate-x-full': !mobileSidebarOpen,
    'translate-x-0': mobileSidebarOpen,
  }" aria-label="Main Sidebar Navigation">
      <!-- Sidebar Header -->
      <div class="flex h-20 w-full flex-none items-center justify-between px-8">
        <!-- Brand -->
        <router-link to="/" class="inline-flex items-center gap-2 text-2xl font-bold tracking-wide text-secondary transition hover:opacity-75 active:opacity-100">
            <span>LinguaGo</span>
        </router-link>
        <!-- END Brand -->

      </div>
      <!-- END Sidebar Header -->

      <!-- Main Navigation -->
      <div class="w-full grow space-y-3 p-4">
        <AsideLink link="/dashboard/home" label="Accueil" icon="house-heart" />
        <AsideLink link="/dashboard/to-exercise" label="S'exercer" icon="learn" />
        <AsideLink link="/dashboard/favorites" label="Mes favoris" icon="star" />
      </div>
      <!-- END Main Navigation -->

      <!-- Sub Navigation -->
      <div class="w-full flex-none space-y-3 p-4">
        <AsideLink link="/dashboard/settings" label="Paramètres" icon="gear" />
      </div>
      <!-- END Sub Navigation -->
    </aside>
</template>

<script setup lang="ts">
import AsideLink from './AsideLink.vue';

</script>