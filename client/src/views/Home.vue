<template>
    <div class="bg-background min-h-screen">
        <Hero />
        <WhyChoose />
        <HowItWorks />
        <Offers />
        <Testimonials />
    </div>
    <Footer />
</template>

<script setup lang="ts">
import Hero from '../components/Home/Hero.vue';
import WhyChoose from '../components/Home/WhyChoose.vue';
import HowItWorks from '../components/Home/HowItWorks.vue';
import Offers from '../components/Home/Offers.vue';
import Testimonials from '../components/Home/Testimonials.vue';
import Footer from '../components/Footer.vue';
</script>