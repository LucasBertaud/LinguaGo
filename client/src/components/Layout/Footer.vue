<template>
    <footer class="bg-primary text-white py-10">
        <div class="container mx-auto px-6 grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="flex flex-col space-y-4">
                <h2 class="text-2xl font-bold">LinguaGo</h2>
                <p class="text-gray-300">
                    Apprenez l'anglais de manière interactive et ludique avec LinguaGo. Rejoignez-nous pour une expérience unique d'apprentissage.
                </p>
            </div>
            <div class="flex flex-col space-y-2">
                <h3 class="text-xl font-semibold">Liens utiles</h3>
                <router-link to="/" class="hover:underline">Accueil</router-link>
                <router-link to="/levels" class="hover:underline">Niveaux</router-link>
                <router-link to="#" class="hover:underline">Tarifs</router-link>
                <router-link to="#" class="hover:underline">Contact</router-link>
            </div>
            <div class="flex flex-col space-y-4">
                <h3 class="text-xl font-semibold">Suivez-nous</h3>
                <a href="#" class="hover:underline">Facebook</a>
                <a href="#" class="hover:underline">Twitter</a>
                <a href="#" class="hover:underline">Instagram</a>
                <a href="#" class="hover:underline">LinkedIn</a>
            </div>
        </div>
        <div class="border-t border-gray-600 mt-6 pt-6 text-center" v-html="`&copy; ${new Date().getFullYear()} LinguaGo. Tous droits réservés.`">
        </div>
    </footer>
</template>