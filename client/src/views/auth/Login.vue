<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-100 bg-cover bg-center">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md mx-4">
      <h1 class="text-4xl font-bold mb-6 text-center text-primary">Connexion</h1>
      <form @submit.prevent="handleSubmit">
        <div class="mb-4">
          <label for="email" class="block text-gray-700">Email</label>
          <div class="relative">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
              <svg class="h-4 w-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" width="128" height="128"
                viewBox="0 0 24 24">
                <path fill-rule="evenodd"
                  d="M19 4H5a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3V7a3 3 0 0 0-3-3m-.67 2L12 10.75L5.67 6ZM19 18H5a1 1 0 0 1-1-1V7.25l7.4 5.55a1 1 0 0 0 .6.2a1 1 0 0 0 .6-.2L20 7.25V17a1 1 0 0 1-1 1" />
              </svg>
            </span>
            <input v-model="email" id="email" type="email" placeholder="Email"
              class="w-full px-10 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary" />
          </div>
          <Error :error="emailError" />
        </div>
        <div class="mb-6">
          <label for="password" class="block text-gray-700">Mot de passe</label>
          <PasswordInput v-model="password" id="password" placeholder="Mot de passe" />
          <Error :error="passwordError" />
        </div>
        <button type="submit"
          class="w-full bg-primary text-white py-2 rounded-lg hover:bg-primary-dark focus:outline-none focus:ring-2 focus:ring-primary focus:ring-opacity-50 cursor-pointer">Connexion</button>
      </form>
      <div class="mt-4 text-center">
        <router-link to="/register" class="text-primary hover:underline">Pas encore inscrit ? Créez un
          compte</router-link>
      </div>
      <LoadingSpinner v-if="isLoading" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useStore } from 'vuex';
import { useToast } from 'vue-toastification';
import Error from '../../components/Form/Error.vue';
import LoadingSpinner from '../../components/LoadingSpinner.vue';
import { validateEmail, validatePasswordLength } from '../../utils/validation.utils';
import PasswordInput from '../../components/Form/PasswordInput.vue';
import { networkObserver } from '../../services/network-observer';

const email = ref('');
const password = ref('');
const emailError = ref<string | null>(null);
const passwordError = ref<string | null>(null);
const isLoading = ref(false);
const router = useRouter();
const store = useStore();
const toast = useToast();

const handleSubmit = async () => {
  if (navigator.onLine === false) {
    toast.error("Vous devez être connecté à internet pour vous connecter.");
    return;
  } else {
    networkObserver.removeOffline();
  }

  emailError.value = null;
  passwordError.value = null;

  if (!validateEmail(email.value)) {
    emailError.value = "L'adresse email n'est pas valide.";
  }

  if (!validatePasswordLength(password.value)) {
    passwordError.value = "Le mot de passe doit contenir au moins 10 caractères.";
  }

  if (emailError.value || passwordError.value) {
    toast.error("Veuillez corriger les erreurs avant de continuer.");
    return;
  }

  isLoading.value = true;

  try {
    await store.dispatch('login', {
      email: email.value,
      password: password.value,
    });
    router.push({ path: '/dashboard' });
  } catch (error) {
    toast.error("Erreur de connexion. Veuillez vérifier vos identifiants.");
  } finally {
    isLoading.value = false;
  }
};
</script>