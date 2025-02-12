<template>
    <section
        class="w-full h-screen flex flex-col items-center justify-center text-center bg-gradient-to-b from-primary to-blue-600 text-white px-6">
        <h1 class="text-6xl font-extrabold leading-tight mb-6">
            Améliorez votre anglais avec <span class="text-secondary">LinguaGo</span>
        </h1>
        <p class="text-lg text-gray-200 mb-8">
            Une méthode interactive et ludique pour apprendre l’anglais efficacement.
        </p>
        <router-link to="/levels"
            class="bg-secondary text-black font-bold py-3 px-6 rounded-full shadow-md hover:bg-opacity-90 transition duration-300">
            Commencer maintenant
        </router-link>
    </section>
</template>