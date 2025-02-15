<template>
    <footer class="bg-primary text-white py-10">
        <div class="container mx-auto px-6 grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="flex flex-col space-y-4">
                <h2 class="text-2xl font-bold">{{ footerTexts.logo }}</h2>
                <p class="text-gray-300">
                    {{ footerTexts.description }}
                </p>
            </div>
            <div class="flex flex-col space-y-2">
                <h3 class="text-xl font-semibold">{{ footerTexts.usefulLinks.title }}</h3>
                <router-link v-for="link in footerTexts.usefulLinks.links" :key="link.name" :to="link.to"
                    class="hover:underline">
                    {{ link.name }}
                </router-link>
            </div>
            <div class="flex flex-col space-y-4">
                <h3 class="text-xl font-semibold">{{ footerTexts.socialLinks.title }}</h3>
                <a v-for="link in footerTexts.socialLinks.links" :key="link.name" :href="link.href"
                    class="hover:underline">
                    {{ link.name }}
                </a>
            </div>
        </div>
        <div class="border-t border-gray-600 mt-6 pt-6 text-center" v-html="footerTexts.copyright">
        </div>
    </footer>
</template>

<script setup lang="ts">
import { footerTexts } from '../../config/content/layout/footer';
</script>