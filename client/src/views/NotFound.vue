<template>
    <div class="min-h-screen flex items-center justify-center bg-gray-100">
        <div class="text-center max-w-xl px-4">

            <h1 class="text-9xl font-bold text-primary mb-4 animate-bounce">404</h1>

            <p class="text-2xl text-gray-600 mb-4">Oups ! Page introuvable</p>
            <p class="text-lg text-gray-500 mb-8">
                La page que vous recherchez semble avoir disparu dans les méandres du web...
                Peut-être était-ce une erreur de frappe ?
            </p>

            <div class="mb-8 text-left bg-white p-6 rounded-lg shadow-md">
                <h2 class="text-xl font-semibold text-primary mb-4">Que faire maintenant ?</h2>
                <ul class="space-y-2 text-gray-600">
                    <li class="flex items-center">
                        - Retourner à l'accueil
                    </li>
                    <li class="flex items-center">
                        - Explorer nos leçons
                    </li>
                    <li class="flex items-center">
                        - Nous contacter si le problème persiste
                    </li>
                </ul>
            </div>

            <div class="flex flex-col sm:flex-row justify-center gap-4">
                <router-link to="/"
                    class="bg-primary text-white px-6 py-3 rounded-full hover:bg-primary-dark transition-colors">
                    Retour à l'accueil
                </router-link>
                <router-link to="/dashboard"
                    class="bg-secondary text-black px-6 py-3 rounded-full hover:bg-opacity-90 transition-colors">
                    Voir les leçons
                </router-link>
            </div>
        </div>
    </div>
</template>