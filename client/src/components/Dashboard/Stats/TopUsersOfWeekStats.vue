<template>
    <div class="row-span-3 bg-white shadow rounded-lg">
        <div class="flex items-center justify-between px-6 py-5 font-semibold border-b border-gray-100">
            <p>Top utilisateurs de la semaine</p>
        </div>
        <div class="overflow-y-auto m-h-96" v-if="topUsersOfWeek">
            <ul class="p-6 space-y-6">
                <li class="flex items-center" v-for="user in topUsersOfWeek" :key="user.pseudo">
                    <div class="h-10 w-10 mr-3 bg-gray-100 rounded-full overflow-hidden">
                        <img src="https://randomuser.me/api/portraits/women/82.jpg" alt="Annette Watson profile picture">
                    </div>
                    <p class="text-gray-600">{{ user.pseudo }}</p>
                    <p class="ml-auto font-semibold">{{ user.pointsWon }} pts</p>
                </li>
            </ul>
        </div>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import Database from '../../../utils/database.utils';

const topUsersOfWeek = ref<{
    pseudo: string;
    pointsWon: number;
}[]>();

const fetchTopUsersOfWeek = async () => {
    try {
        const response = await Database.getAll('user-completed-exercise/top-users-of-week');
        topUsersOfWeek.value = response;
    } catch (error) {
        console.error(error);
    }
}

onMounted(() => {
    fetchTopUsersOfWeek();
});
</script>