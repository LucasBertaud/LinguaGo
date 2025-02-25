<template>
    <Popper arrow class="mr-4" @open:popper="handleOpen" v-if="!isNotificationBlocked">
        <button class="relative p-2 text-white hover:bg-gray-100 hover:text-gray-600 focus:bg-gray-100 focus:text-gray-600 rounded-full cursor-pointer">
            <span class="sr-only">Notifications</span>
            <span class="absolute top-0 right-0 h-2 w-2 mt-1 mr-2 bg-red-500 rounded-full"></span>
            <span class="absolute top-0 right-0 h-2 w-2 mt-1 mr-2 bg-red-500 rounded-full animate-ping"></span>
            <svg aria-hidden="true" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="h-6 w-6">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
            </svg>
        </button>
        <template #content>
            <label class="inline-flex items-center cursor-pointer">
                <input type="checkbox" @change="handleCheckbox" :checked="areNotificationsActivate" class="sr-only peer">
                <div class="relative w-11 h-6 bg-gray-300 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-primary-light rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
                <span class="ms-3 text-sm font-medium text-black">{{ areNotificationsActivate ? 'Enlever les notifications' : 'Ajouter les notifications' }}</span>
            </label>
        </template>
    </Popper>
</template>

<script setup lang="ts">
import Popper from 'vue3-popper';
import { ref } from 'vue';
import Database from '../../../utils/database.utils';
import { subscriberService } from '../../../services/subscriber.service';
import NotificationInterface from '../../../interface/notification.interface';

const isNotificationBlocked = ref<boolean>(Notification.permission === "denied");
const areNotificationsAllowed = ref<boolean>(false);
const areNotificationsActivate = ref<boolean>(false);

const handleOpen = async () => {
    areNotificationsAllowed.value = Notification && Notification.permission === "granted";
    if(areNotificationsAllowed.value) {
        fetchNotificationInDatabase();
    }
}

const fetchNotificationInDatabase = async () => {
    const response = await Database.getAll("notification/user");
    areNotificationsActivate.value = response.isActivate;
}

const handleCheckbox = async () => {
    if(!areNotificationsAllowed.value){
        const response = await subscriberService.subscribe();
        isNotificationBlocked.value = Notification.permission === "denied";
        if(!response) return;
        const notification: NotificationInterface = response.data;
        areNotificationsAllowed.value = notification.isActivate;
        areNotificationsActivate.value = notification.isActivate;
    } else {
        const response = await Database.update("notification", '', { isActivate: !areNotificationsActivate.value });
        if(!response) return;
        areNotificationsActivate.value = response.isActivate;
    }
}
</script>