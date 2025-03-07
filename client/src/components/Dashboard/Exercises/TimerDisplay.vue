<template>
    <div class="bg-primary-light py-2 pl-6 pr-3 rounded-full flex flex-row items-center">
        <Icon 
        svg-path="/assets/images/icons/timer.svg"
        :options="{
            dynamicClasses: '[&>svg]:w-5.5 [&>svg]:h-auto [&>svg>*]:stroke-primary'
        }" />
        <TimerSeconds />
    </div>
</template>

<script setup lang="ts">
import Icon from '../../Icon.vue';
import TimerSeconds from './TimerSeconds.vue';
</script>