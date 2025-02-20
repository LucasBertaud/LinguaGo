<template>
    <div class="flex items-center p-8 bg-white shadow rounded-lg">
        <div 
            class="inline-flex flex-shrink-0 items-center justify-center h-16 w-16 rounded-full mr-6"
            :class="iconColor[color].background + ' ' + iconColor[color].text">
            <Icon :svg-path="`/assets/images/icons/${icon}.svg`" :options="{
                dynamicClasses: `${iconClasses}`
            }" />
        </div>
        <div>
            <span class="block text-2xl font-bold">{{ stats }}</span>
            <span class="block text-gray-500">{{ title }}</span>
        </div>
    </div>
</template>

<script setup lang="ts">
import Icon from '../../Icon.vue';

defineProps<{
    stats: string;
    title: string;
    icon: string;
    color: string;
    iconClasses?: string;
}>();

const iconColor: Record<string, { background: string; text: string }> = {
    blue: {
        background: "bg-blue-100",
        text: "text-blue-600",
    },
    yellow: {
        background: "bg-yellow-100",
        text: "text-yellow-600",
    },
    green: {
        background: "bg-green-100",
        text: "text-green-600",
    },
    red: {
        background: "bg-red-100",
        text: "text-red-600",
    }
}
</script>