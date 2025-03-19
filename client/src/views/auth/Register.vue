<template>
  <div
    class="min-h-screen flex items-center justify-center bg-gray-100 bg-cover bg-center"
  >
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md mx-4">
      <h1 class="text-4xl font-bold mb-6 text-center text-primary">
        Inscription
      </h1>
      <form @submit.prevent="handleSubmit">
        <div class="mb-4">
          <label for="pseudo" class="block text-gray-700">Pseudo</label>
          <div class="relative">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
              <svg
                class="h-4 w-4 text-gray-400"
                xmlns="http://www.w3.org/2000/svg"
                width="128"
                height="128"
                viewBox="0 0 48 48"
              >
                <path
                  fill="none"
                  stroke="#000000"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="4"
                  d="M24 20a7 7 0 1 0 0-14a7 7 0 0 0 0 14M6 40.8V42h36v-1.2c0-4.48 0-6.72-.872-8.432a8 8 0 0 0-3.496-3.496C35.92 28 33.68 28 29.2 28H18.8c-4.48 0-6.72 0-8.432.872a8 8 0 0 0-3.496 3.496C6 34.08 6 36.32 6 40.8"
                />
              </svg>
            </span>
            <input
              v-model="pseudo"
              id="pseudo"
              type="text"
              placeholder="Pseudo"
              class="w-full px-10 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>
          <Error :error="pseudoError" />
        </div>
        <div class="mb-4">
          <label for="email" class="block text-gray-700">Adresse email</label>
          <div class="relative">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
              <svg
                class="h-4 w-4 text-gray-400"
                xmlns="http://www.w3.org/2000/svg"
                width="128"
                height="128"
                viewBox="0 0 24 24"
              >
                <path
                  fill="#000000"
                  d="M19 4H5a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h14a3 3 0 0 0 3-3V7a3 3 0 0 0-3-3m-.67 2L12 10.75L5.67 6ZM19 18H5a1 1 0 0 1-1-1V7.25l7.4 5.55a1 1 0 0 0 .6.2a1 1 0 0 0 .6-.2L20 7.25V17a1 1 0 0 1-1 1"
                />
              </svg>
            </span>
            <input
              v-model="email"
              id="email"
              type="email"
              placeholder="Email"
              class="w-full px-10 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>
          <Error :error="emailError" />
        </div>
        <div class="mb-6">
          <label for="password" class="block text-gray-700">Mot de passe</label>
          <PasswordInput
            v-model="password"
            id="password"
            placeholder="Mot de passe"
          />
          <Error :error="passwordError" />
        </div>
        <button
          type="submit"
          class="w-full bg-primary text-white py-2 rounded-lg hover:bg-primary-dark focus:outline-none focus:ring-2 focus:ring-primary focus:ring-opacity-50 cursor-pointer"
        >
          Inscription
        </button>
      </form>
      <div class="mt-4 text-center">
        <router-link to="/login" class="text-primary hover:underline">
          Déjà inscrit ? Connectez-vous
        </router-link>
      </div>
      <LoadingSpinner v-if="isLoading" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import Error from "../../components/Form/Error.vue";
import LoadingSpinner from "../../components/LoadingSpinner.vue";
import PasswordInput from "../../components/Form/PasswordInput.vue";
import {
  validateEmail,
  validatePasswordLength,
} from "../../utils/validation.utils";
import { Database } from "../../utils/database.utils";

const pseudo = ref("");
const email = ref("");
const password = ref("");
const pseudoError = ref<string | null>(null);
const emailError = ref<string | null>(null);
const passwordError = ref<string | null>(null);
const isLoading = ref(false);
const router = useRouter();
const toast = useToast();

const handleSubmit = async () => {
  pseudoError.value = null;
  emailError.value = null;
  passwordError.value = null;

  if (!pseudo.value) {
    pseudoError.value = "Le pseudo est requis.";
  }

  if (!validateEmail(email.value)) {
    emailError.value = "L'adresse email n'est pas valide.";
  }

  if (!validatePasswordLength(password.value)) {
    passwordError.value =
      "Le mot de passe doit contenir au moins 10 caractères.";
  }

  if (pseudoError.value || emailError.value || passwordError.value) {
    toast.error("Veuillez corriger les erreurs avant de continuer.");
    return;
  }

  isLoading.value = true;

  try {
    const response = await Database.post("user/register", {
      pseudo: pseudo.value,
      email: email.value,
      password: password.value,
    });
    if (response && response.status === 201) {
      toast.success("Inscription réussie !");
      router.push({ path: "/login" });
    } else {
      toast.error("L'inscription a échoué. Veuillez réessayer.");
    }
  } catch (error) {
    toast.error("L'inscription a échoué. Veuillez réessayer.");
  } finally {
    isLoading.value = false;
  }
};
</script>
