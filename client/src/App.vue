<template>
  <Navbar />
  <div class="bg-background min-h-screen">
    <router-view />
  </div>
  <Footer />
</template>

<script setup lang="ts">
import Navbar from './components/Layout/Navbar.vue';
import Footer from './components/Layout/Footer.vue';

defineOptions({
  name: 'App'
});
</script>
