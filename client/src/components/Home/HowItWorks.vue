<template>
    <section class="py-20 px-6 text-center">
        <h2 class="text-4xl font-bold text-primary text-center mb-10">{{ howItWorksTexts.title }}</h2>
        <div class="flex flex-col space-y-6 md:w-2/3 mx-auto text-center">
            <div class="flex flex-col items-center" v-for="(step, index) in howItWorksTexts.steps" :key="index">
                <div class="w-12 h-12 bg-secondary text-white flex items-center justify-center rounded-full mb-4">{{
                    index + 1 }}</div>
                <p class="text-lg">{{ step }}</p>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
import { howItWorksTexts } from '../../config/content/home';
</script>