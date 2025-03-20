# LinguaGo - Guide d'installation et d'utilisation

LinguaGo est une application PWA d'apprentissage des langues développée avec Vue.js et NestJS.

## Prérequis

- Node.js 20.x ou plus récent
- npm 8.x ou plus récent
- PostgreSQL 16+
- Git

## Installation côté client

Le frontend est développé avec Vue 3, TypeScript et Vite.

```
# Se positionner dans le répertoire client
cd client

# Installer les dépendances
npm install

# Créer un fichier d'environnement
cp .env.example .env
```

Configurez les variables d'environnement dans le fichier .env. Vous pouvez retrouver les différentes variables nécessaires dans le fichier .env.example.

Pour démarrer en mode développement :

```
npm run dev
```
Pour déployer l'application PWA :

```
# Construction de l'application
npm run build

# Prévisualisation du build
npm run preview
```

> **Note** : Pour tester les fonctionnalités PWA (mise en cache, notifications), utilisez la version de production (build + preview).

## Installation côté server

Le backend est développé avec NestJS et Prisma ORM.

```
# Se positionner dans le répertoire serveur
cd server

# Installer les dépendances
npm install

# Créer un fichier d'environnement
cp .env.example .env
```

Configurez les variables d'environnement dans le fichier .env. Vous pouvez retrouver les différentes variables nécessaires dans le fichier .env.example.

### Configuration de la base de données

Utiliser le dump SQL :

```
# D'abord, créez une base de données PostgreSQL vide
createdb linguago
# ou via psql
psql -U votre_utilisateur -c "CREATE DATABASE linguago;"

# Importez le dump SQL (situé dans le dossier database à la racine du projet)
psql -U votre_utilisateur -d linguago -f database/dump.sql
```

Le fichier dump.sql contient toutes les tables, contraintes, triggers et données initiales nécessaires au bon fonctionnement de l'application.

> **Astuce** : Pour une installation plus simple, vous pouvez utiliser un SGBD graphique comme pgAdmin ou DBeaver, créer manuellement une base de données et y importer le script SQL directement depuis l'interface.

### Démarrage du serveur

Pour le développement :

```
npm run start:dev
```

Pour la production :

```
# Compilation des fichiers TypeScript
npm run build

# Démarrage du serveur
npm run start:prod
```

## Fonctionnalités

### Installation PWA

LinguaGo peut être installé comme une application native sur :

- Ordinateur : Cliquez sur l'icône d'installation dans la barre d'adresse du navigateur
- Mobile : Utilisez l'option "Ajouter à l'écran d'accueil" dans le menu de votre navigateur

Une fois installée, l'application fonctionne hors ligne et propose une expérience similaire à une application native.

### Mode hors-ligne et cache

L'application fonctionne en mode hors-ligne avec certaines limitations :

- Page d'accueil : Les statistiques ne sont pas disponibles sans connexion
- Exercices :
    - Les exercices standards ne sont pas accessibles hors-ligne
    - Les exercices de prononciation nécessitent également une connexion
- Favoris : Les exercices ajoutés en favoris sont stockés dans le cache et restent disponibles hors-ligne !
- Sauvegarde des progrès :
    - Les réponses sont stockées temporairement en localStorage
    - Elles sont synchronisées avec la base de données dès que la connexion est rétablie

Pour tester le mode hors-ligne, ajoutez d'abord des exercices à vos favoris en étant connecté, puis désactivez votre connexion internet.

### Apprentissage

- Exercices progressifs : Différents niveaux de difficulté adaptés à votre progression
- Variété d'exercices : QCM, traduction et vrai ou faux
- Validation intelligente des traductions : Les exercices de traduction libre sont validés à l'aide de Gemini 1.5 Fast (permettant une certaine flexibilité dans vos réponses plutôt qu'une correspondance exacte)
- Entraînement à la prononciation : Parlez et améliorez votre accent grâce à la reconnaissance vocale

### Gestion du profil

- Personnalisation : Modifiez vos informations et préférences via la modal profil
- Avatars : Choisissez parmi une collection d'avatars
- Favoris : Ajoutez les séries d'exercices à vos favoris pour y accéder rapidement depuis la page mes favoris

### Notifications

Pour activer et configurer les notifications :

1. Cliquez sur l'icône de cloche dans le coin supérieur droit
2. Autorisez les notifications lorsque le navigateur vous le demande
3. Paramétrez l'heure de notification (par exemple : 17h00)
4. Sélectionnez la fréquence (quotidienne, tous les 3 jours, hebdomadaire...)

Pour tester les notifications : Nous avons ajouté une option spéciale qui vous permet de recevoir une notification test immédiatement. Sélectionnez l'heure actuelle + 1 minute (par exemple : si l'heure actuelle est 17h05, configurez pour 17h06) pour vérifier que le système fonctionne correctement. Le système utilise une tâche cron côté backend qui s'exécute toutes les minutes pour vérifier et envoyer les notifications aux utilisateurs concernés.

### Suivi des progrès

- Tableau de bord : Vue d'ensemble de votre progression
- Niveaux et points : Suivez votre avancement global
- Statistiques détaillées : Visualisez vos exercices réussis/échoués et le temps passé à apprendre
- Historique d'activité : Consultez votre activité récente et vos performances

### Visualisation des données

- Graphiques interactifs : Visualisez vos progrès avec des graphiques dynamiques
    - Exercices réussis par jour (vue hebdomadaire)
    - Répartition des séries complétées par niveau de difficulté
- Classement : Comparez vos performances à celles des autres utilisateurs dans le classement hebdomadaire

## Logging

Le système de logging capture automatiquement les erreurs dans le dossier logs/. Les logs sont automatiquement :

- Classés par date
- Rotés quotidiennement
- Compressés après rotation
- Supprimés après 14 jours

## Documentation API

La documentation Swagger est disponible à l'URL :

```
http://localhost:3000/api
```

### Dépendances techniques

Voici les principales technologies et bibliothèques utilisées dans ce projet :

#### Backend (NestJS)

| Catégorie | Dépendances | Version |
|-----------|------------|---------|
| **Framework** | `@nestjs/common` | ^11.0.1 |
| | `@nestjs/core` | ^11.0.1 |
| | `@nestjs/platform-express` | ^11.0.1 |
| **Base de données** | `@prisma/client` | ^6.3.1 |
| | `prisma` (dev) | ^6.3.1 |
| **Authentification** | `@nestjs/jwt` | ^11.0.0 |
| | `bcrypt` | ^5.1.1 |
| **Validation** | `class-validator` | ^0.14.1 |
| | `class-transformer` | ^0.5.1 |
| **Documentation API** | `@nestjs/swagger` | ^11.0.3 |
| **Configuration** | `@nestjs/config` | ^4.0.0 |
| **Planification** | `@nestjs/schedule` | ^5.0.1 |
| **Notifications** | `web-push` | ^3.6.7 |
| **Logging** | `winston` | ^3.17.0 |
| | `winston-daily-rotate-file` | ^5.0.0 |
| **Outils** | `cookie-parser` | ^1.4.7 |
| | `reflect-metadata` | ^0.2.2 |

#### Frontend (Vue.js)

| Catégorie | Dépendances | Version |
|-----------|------------|---------|
| **Framework** | `vue` | ^3.5.13 |
| **Routage** | `vue-router` | ^4.5.0 |
| **État global** | `vuex` | ^4.0.2 |
| **UI/UX** | `tailwindcss` | ^4.0.6 |
| | `vue3-carousel` | ^0.14.0 |
| | `vue3-popper` | ^1.5.0 |
| | `@vuepic/vue-datepicker` | ^11.0.1 |
| | `canvas-confetti` | ^1.9.3 |
| | `vue-toastification` | ^2.0.0-rc.5 |
| **HTTP Client** | `axios` | ^1.7.9 |
| **PWA** | `vite-plugin-pwa` | ^0.21.1 |
| | `workbox-window` | ^7.3.0 |
| | `@vite-pwa/assets-generator` | ^0.2.6 |
| **Sécurité** | `dompurify` | ^3.2.4 |
| | `jwt-decode` | ^3.0.0 |
| | `js-cookie` | ^3.0.5 |
| **Visualisation** | `vue3-apexcharts` | ^1.8.0 |
| | `apexcharts` | ^4.5.0 |
| **IA** | `@google/generative-ai` | ^0.23.0 |
| **Outils** | `num-words` | ^1.2.3 |
| **Analytics** | `@microsoft/clarity` | ^1.0.0 |
| **Build** | `vite` | ^6.0.11 |
| | `typescript` | ~5.7.2 |
| | `@vitejs/plugin-vue` | ^5.2.1 |

© 2025 LinguaGo. Tous droits réservés.