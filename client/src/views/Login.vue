<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-100">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
      <h1 class="text-2xl font-bold mb-6 text-center text-primary">Connexion</h1>
      <form @submit.prevent="handleSubmit">
        <div class="mb-4">
          <label for="email" class="block text-gray-700">Email</label>
          <input v-model="email" id="email" type="email" placeholder="Email" required
            class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary" />
        </div>
        <div class="mb-6">
          <label for="password" class="block text-gray-700">Password</label>
          <input v-model="password" id="password" type="password" placeholder="Password" required
            class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary" />
        </div>
        <button type="submit"
          class="w-full bg-primary text-white py-2 rounded-lg hover:bg-primary-dark focus:outline-none focus:ring-2 focus:ring-primary focus:ring-opacity-50">Connexion</button>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useStore } from 'vuex';

const email = ref('');
const password = ref('');
const router = useRouter();
const store = useStore();

const handleSubmit = async () => {
  try {
    await store.dispatch('login', {
      email: email.value,
      password: password.value,
    });
    router.push({ path: '/' });
  } catch (error) {
    console.error('Erreur dans handleSubmit :', error);
  }
};
</script>