<template>
    <section
        class="w-full h-screen flex flex-col items-center justify-center text-center bg-gradient-to-b from-primary to-blue-600 text-white px-6">
        <h1 class="text-6xl font-extrabold leading-tight mb-6">
            {{ heroTexts.title }} <br /><span class="text-secondary">{{ heroTexts.highlight }}<span
                    class="animate-bounce md:absolute">Go</span></span>
        </h1>
        <p class="text-lg text-gray-200 mb-8">
            {{ heroTexts.description }}
        </p>
        <router-link to="/dashboard"
            class="bg-secondary text-black font-bold py-3 px-6 rounded-full shadow-md hover:bg-opacity-90 transition duration-300">
            {{ heroTexts.buttonText }}
        </router-link>
    </section>
</template>

<script setup lang="ts">
import { heroTexts } from '../../config/content/home';
</script>