<template>
    <nav class="bg-primary text-white py-4 sticky top-0 w-full z-50">
        <div class="container mx-auto flex justify-between items-center px-4">
            <router-link to="/" class="text-2xl font-bold">LinguaGo</router-link>
            <div class="hidden md:flex space-x-4">
                <router-link v-if="!isAuthenticated" to="/login"
                    class="relative flex items-center text-white hover:text-white">
                    <span class="hover-underline-animation">Connexion</span>
                </router-link>
                <router-link v-if="isAuthenticated" to="/profile"
                    class="relative flex items-center text-white hover:text-white">
                    <span class="hover-underline-animation">Profil</span>
                </router-link>
                <button v-if="isAuthenticated" @click="logout"
                    class="relative flex items-center text-white hover:text-white cursor-pointer">
                    <span class="hover-underline-animation">Déconnexion</span>
                </button>
            </div>
            <button @click="toggleMenu" class="md:hidden flex items-center">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7">
                    </path>
                </svg>
            </button>
        </div>
        <transition name="slide">
            <div v-if="menuOpen"
                class="fixed inset-0 bg-primary p-4 md:hidden flex flex-col items-center justify-center space-y-6">
                <button @click="toggleMenu" class="absolute top-4 right-4">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12">
                        </path>
                    </svg>
                </button>
                <router-link @click="toggleMenu" to="/"
                    class="block py-2 px-6 text-2xl hover:bg-primary-dark text-center w-full">
                    🏠 Accueil
                </router-link>
                <router-link v-if="!isAuthenticated" @click="toggleMenu" to="/login"
                    class="block py-2 px-6 text-2xl hover:bg-primary-dark text-center w-full">
                    🔑 Connexion
                </router-link>
                <router-link v-if="isAuthenticated" @click="toggleMenu" to="/profile"
                    class="block py-2 px-6 text-2xl hover:bg-primary-dark text-center w-full">
                    👤 Profil
                </router-link>
                <button v-if="isAuthenticated" @click="logout"
                    class="block w-full text-center py-2 px-6 text-2xl hover:bg-primary-dark">
                    🚪 Déconnexion
                </button>
            </div>
        </transition>
    </nav>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useStore } from 'vuex';
import { useRouter } from 'vue-router';

const store = useStore();
const router = useRouter();

const isAuthenticated = computed(() => store.getters.isAuthenticated);
const menuOpen = ref(false);

const toggleMenu = () => {
    menuOpen.value = !menuOpen.value;
};

const logout = async () => {
    await store.dispatch('logout');
    router.push('/');
    menuOpen.value = false;
};
</script>

<style scoped>
.slide-enter-active,
.slide-leave-active {
    transition: transform 0.3s ease;
}

.slide-enter-from,
.slide-leave-to {
    transform: translateX(100%);
}

.slide-enter-to,
.slide-leave-from {
    transform: translateX(0%);
}

.hover-underline-animation {
    position: relative;
    color: white;
    text-decoration: none;
}

.hover-underline-animation::after {
    content: '';
    position: absolute;
    width: 0;
    height: 2px;
    display: block;
    margin-top: 5px;
    left: 50%;
    transform: translateX(-50%);
    background: #ffc503;
    transition: width 0.3s ease;
}

.hover-underline-animation:hover::after {
    width: 100%;
}
</style>