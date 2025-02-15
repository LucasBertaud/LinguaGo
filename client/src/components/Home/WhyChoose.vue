<template>
    <section class="py-20 px-6 text-center bg-gray-100">
        <h2 class="text-4xl font-bold text-primary mb-10">{{ whyChooseTexts.title }}</h2>
        <div class="grid md:grid-cols-3 gap-8">
            <div class="flex flex-col items-center text-center" v-for="(reason, index) in whyChooseTexts.reasons"
                :key="index">
                <span class="text-5xl text-secondary mb-4">{{ reason.icon }}</span>
                <h3 class="text-2xl font-bold text-primary mb-3">{{ reason.title }}</h3>
                <p class="text-text">{{ reason.description }}</p>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
import { whyChooseTexts } from '../../config/content/home';
</script>