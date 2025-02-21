<template>
    <div class="min-h-screen bg-gray-100 py-10">
        <div class="container mx-auto px-6">
            <div class="bg-white p-8 rounded-lg shadow-lg">
                <h1 class="text-4xl font-bold text-primary mb-6">{{ profileTexts.title }}</h1>
                <div v-if="user" class="flex flex-col md:flex-row items-center md:items-start">
                    <div>
                        <h2 class="text-2xl font-semibold">{{ user.pseudo }}</h2>
                        <p class="text-gray-600">{{ user.email }}</p>
                    </div>
                </div>
            </div>
        </div>
        <LoadingSpinner v-if="isLoading" />
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useToast } from 'vue-toastification';
import Database from '../../utils/database.utils';
import { profileTexts } from '../../config/content/profile';
import type { User } from '../../interface/user.interface';
import LoadingSpinner from '../../components/LoadingSpinner.vue';

const user = ref<User | null>(null);
const isLoading = ref(true);
const toast = useToast();

const fetchUserProfile = async () => {
    try {
        const data = await Database.getOne('user', 'profile');
        user.value = data;
    } catch (error) {
        toast.error(profileTexts.errorMessage);
    } finally {
        isLoading.value = false;
    }
};

onMounted(() => {
    fetchUserProfile();
});
</script>