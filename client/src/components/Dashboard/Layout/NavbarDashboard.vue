<template>
    <header class="flex items-center h-20 px-6 sm:px-10 bg-primary">
        <button @click="toggleMenu" class="cursor-pointer block sm:hidden relative flex-shrink-0 p-2 mr-2 text-gray-600 hover:bg-gray-100 hover:text-gray-800 focus:bg-gray-100 focus:text-gray-800 rounded-full">
            <span class="sr-only">Menu</span>
            <svg aria-hidden="true" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="h-6 w-6">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h7" />
            </svg>
        </button>
        <div class="flex flex-shrink-0 items-center ml-auto">
            <button @click="openProfileModal" class="cursor-pointer group inline-flex items-center p-2 hover:bg-gray-100 focus:bg-gray-100 rounded-lg">
                <span class="sr-only">User Menu</span>
                <div class="hidden md:flex md:flex-col md:items-end md:leading-tight">
                    <span class="font-semibold text-white group-hover:text-slate-600 group-focus:text-slate-600">{{ userInfo?.pseudo }}</span>
                    <span class="text-sm text-gray-300 group-hover:text-gray-500 group-focus:text-gray-500">{{ userInfo?.email }}</span>
                </div>
                <span class="h-12 w-12 ml-2 sm:ml-3 mr-2 bg-gray-100 rounded-full overflow-hidden">
                    <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="user profile photo" class="h-full w-full object-cover">
                </span>
                <svg aria-hidden="true" viewBox="0 0 20 20" fill="currentColor" class="hidden sm:block h-6 w-6 text-white group-hover:text-slate-600 group-focus:text-slate-600">
                    <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg> 
            </button>
            <div class="border-l pl-3 ml-3 space-x-1">
                <NotificationButton />
                <button v-if="isAuthenticated" @click="logout" class="relative p-2 text-white hover:bg-gray-100 hover:text-gray-600 focus:bg-gray-100 focus:text-gray-600 rounded-full cursor-pointer">
                    <span class="sr-only">Déconnexion</span>
                    <svg aria-hidden="true" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="h-6 w-6">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                    </svg>
                </button>
            </div>
        </div>
        <transition name="slide">
            <div v-if="menuOpen"
                class="fixed inset-0 bg-primary p-4 md:hidden flex flex-col items-center justify-center space-y-6 z-50">
                <button @click="toggleMenu" class="absolute top-4 left-4 cursor-pointer">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12">
                        </path>
                    </svg>
                </button>
                <router-link @click="toggleMenu" to="/"
                    class="block py-2 px-6 text-white text-2xl hover:bg-primary-dark text-center w-full">
                    {{ navbarTexts.links.home }}
                </router-link>
                <router-link v-if="!isAuthenticated" @click="toggleMenu" to="/login"
                    class="block py-2 px-6 text-white text-2xl hover:bg-primary-dark text-center w-full">
                    {{ navbarTexts.links.login }}
                </router-link>
                <router-link v-if="isAuthenticated" @click="toggleMenu" to="/profile"
                    class="block py-2 px-6 text-white text-2xl hover:bg-primary-dark text-center w-full">
                    {{ navbarTexts.links.profile }}
                </router-link>
                <button v-if="isAuthenticated" @click="logout"
                    class="block w-full text-white text-center py-2 px-6 text-2xl hover:bg-primary-dark">
                    {{ navbarTexts.links.logout }}
                </button>
            </div>
        </transition>
    </header>
    <UserProfileModal 
        :is-open="isProfileModalOpen"
        @close="closeProfileModal"
    />
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import { useStore } from 'vuex';
import { useRouter } from 'vue-router';
import { navbarTexts } from '../../../config/content/layout/navbar';
import NotificationButton from '../Button/NotificationButton.vue';
import type { User } from '../../../interface/user.interface';
import UserProfileModal from '../../Modal/UserProfileModal.vue';

const store = useStore();
const router = useRouter();
const menuOpen = ref(false);

const isAuthenticated = computed(() => store.getters.isAuthenticated);
const userInfo = computed(() => store.getters.getUser);

const isProfileModalOpen = ref(false);

const logout = async () => {
    await store.dispatch('logout');
    router.push('/');
    menuOpen.value = false;
};

const toggleMenu = () => {
    menuOpen.value = !menuOpen.value;
};

const openProfileModal = () => {
    isProfileModalOpen.value = true;
};

const closeProfileModal = () => {
    isProfileModalOpen.value = false;
};
</script>

<style scoped>
.slide-enter-active,
.slide-leave-active {
    transition: transform 0.3s ease;
}

.slide-enter-from,
.slide-leave-to {
    transform: translateX(-100%);
}

.slide-enter-to,
.slide-leave-from {
    transform: translateX(0%);
}
</style>