<template>
    <section class="py-20 px-6 bg-gray-100 text-center">
        <h2 class="text-4xl font-bold text-primary mb-10">{{ offersTexts.title }}</h2>
        <div class="flex flex-wrap justify-center gap-8">
            <div v-for="(offer, index) in offersTexts.offers" :key="index"
                :class="`max-w-sm bg-white p-6 rounded-lg shadow-lg border-t-4 ${offer.borderColor}`">
                <h3 :class="`text-2xl font-bold mb-3 ${offer.textColor}`">{{ offer.name }}</h3>
                <p class="text-text">{{ offer.description }}</p>
                <p :class="`text-3xl font-bold my-4 ${offer.textColor}`">{{ offer.price }}</p>
                <button :class="`${offer.buttonBgColor} ${offer.buttonTextColor} py-2 px-4 rounded-full shadow-md`">{{
                    offer.buttonText }}</button>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
import { offersTexts } from '../../config/content/home';
</script>