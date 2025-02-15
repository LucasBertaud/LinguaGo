<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-100 bg-cover bg-center">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md mx-4">
      <h1 class="text-4xl font-bold mb-6 text-center text-primary">{{ formTexts.login }}</h1>
      <form @submit.prevent="handleSubmit">
        <div class="mb-4">
          <label for="email" class="block text-gray-700">{{ formTexts.emailLabel }}</label>
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
          <label for="password" class="block text-gray-700">{{ formTexts.passwordLabel }}</label>
          <div class="relative">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
              <svg class="h-4 w-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                <path fill-rule="evenodd"
                  d="M24 14h-2V8a6 6 0 0 0-12 0v6H8a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V16a2 2 0 0 0-2-2M12 8a4 4 0 0 1 8 0v6h-8Zm12 20H8V16h16Z" />
              </svg>
            </span>
            <input v-model="password" id="password" type="password" placeholder="Mot de passe"
              class="w-full px-10 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary" />
          </div>
          <Error :error="passwordError" />
        </div>
        <button type="submit"
          class="w-full bg-primary text-white py-2 rounded-lg hover:bg-primary-dark focus:outline-none focus:ring-2 focus:ring-primary focus:ring-opacity-50 cursor-pointer">{{
            formTexts.login }}</button>
      </form>
      <div class="mt-4 text-center">
        <router-link to="/register" class="text-primary hover:underline">{{ formTexts.registerLink }}</router-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useStore } from 'vuex';
import { useToast } from 'vue-toastification';
import Error from '../../components/Form/Error.vue';
import { errorMessages } from '../../config/error/auth/login';
import { formTexts } from '../../config/form/auth/login';
import { validateEmail, validatePasswordLength } from '../../utils/validation';

const email = ref('');
const password = ref('');
const emailError = ref<string | null>(null);
const passwordError = ref<string | null>(null);
const router = useRouter();
const store = useStore();
const toast = useToast();

const handleSubmit = async () => {
  emailError.value = null;
  passwordError.value = null;

  if (!validateEmail(email.value)) {
    emailError.value = errorMessages.invalidEmail;
  }

  if (!validatePasswordLength(password.value)) {
    passwordError.value = errorMessages.shortPassword;
  }

  if (emailError.value || passwordError.value) {
    toast.error(errorMessages.fixErrors);
    return;
  }

  try {
    await store.dispatch('login', {
      email: email.value,
      password: password.value,
    });
    toast.success(formTexts.loginSuccess);
    router.push({ path: '/' });
  } catch (error) {
    toast.error(errorMessages.loginFailed);
  }
};
</script>