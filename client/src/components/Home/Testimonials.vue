<template>
    <section class="py-20 text-center px-6">
        <h2 class="text-4xl font-bold text-primary mb-10">{{ testimonialsTexts.title }}</h2>
        <div class="flex flex-wrap justify-center gap-6">
            <blockquote v-for="(testimonial, index) in testimonialsTexts.testimonials" :key="index"
                class="max-w-sm bg-white p-6 rounded-lg shadow-md">
                <p class="italic">{{ testimonial.quote }}</p>
                <span class="block mt-4 font-bold">{{ testimonial.author }}</span>
            </blockquote>
        </div>
    </section>
</template>

<script setup lang="ts">
import { testimonialsTexts } from '../../config/content/home';
</script>