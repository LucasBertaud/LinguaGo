<template>
    <div class="flex flex-col row-span-3 bg-white shadow rounded-lg">
        <div class="flex items-center justify-between px-6 py-5 font-semibold border-b border-gray-100">
            <p>Top utilisateurs de la semaine</p>
        </div>
        <div class="p-4 flex-grow">
            <div class="overflow-y-auto" v-if="topUsersOfWeek && topUsersOfWeek.length > 0">
                <ul class="space-y-6">
                    <li class="flex items-center" v-for="user in topUsersOfWeek" :key="user.pseudo">
                        <div class="h-10 w-10 mr-3 rounded-full overflow-hidden flex items-center justify-center"
                             v-if="user.avatar?.svg"
                             v-html="sanitizeAvatar(user.avatar.svg)">
                        </div>
                        <p class="text-gray-600">{{ user.pseudo }}</p>
                        <p class="ml-auto font-semibold">{{ user.pointsWon }} pts</p>
                    </li>
                </ul>
            </div>
            <p v-else class="text-center italic h-full content-center">
                Aucun utilisateur n'a gagné de points cette semaine
            </p>
        </div>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import DOMPurify from 'dompurify';
import { Database } from '../../../utils/database.utils';

const topUsersOfWeek = ref<{
    pseudo: string;
    pointsWon: number;
    avatar: { 
        svg: string 
    };
}[]>();

const fetchTopUsersOfWeek = async () => {
    try {
        const response = await Database.get('user-completed-exercise/top-users-of-week');
        topUsersOfWeek.value = response.data;
    } catch (error) {
        console.error(error);
    }
}

const sanitizeAvatar = (svg: string) => {
    return DOMPurify.sanitize(svg);
};

onMounted(() => {
    fetchTopUsersOfWeek();
});
</script>