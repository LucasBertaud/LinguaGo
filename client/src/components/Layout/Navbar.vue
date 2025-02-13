<template>
    <nav class="bg-primary text-white py-4 fixed top-0 left-0 w-full z-50">
        <div class="container mx-auto flex justify-between items-center">
            <router-link to="/" class="text-2xl font-bold hover:underline">LinguaGo</router-link>
            <div class="flex space-x-4">
                <router-link v-if="!isAuthenticated" to="/login" class="hover:underline flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h14M12 5l7 7-7 7">
                        </path>
                    </svg>
                    Connexion
                </router-link>
                <router-link v-if="isAuthenticated" to="/profile" class="hover:underline flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M5.121 17.804A9 9 0 1118.879 6.196a9 9 0 01-13.758 11.608z"></path>
                    </svg>
                    Profil
                </router-link>
                <button v-if="isAuthenticated" @click="logout" class="hover:underline flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H4a3 3 0 01-3-3V7a3 3 0 013-3h6a3 3 0 013 3v1">
                        </path>
                    </svg>
                    Déconnexion
                </button>
            </div>
        </div>
    </nav>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useStore } from 'vuex';
import { useRouter } from 'vue-router';

const store = useStore();
const router = useRouter();

const isAuthenticated = computed(() => store.getters.isAuthenticated);

const logout = async () => {
    await store.dispatch('logout');
    router.push('/');
};
</script>