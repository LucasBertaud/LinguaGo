<template>
    <section class="py-20 px-6 bg-gray-100 text-center">
      <h2 class="text-4xl font-bold text-primary mb-10">Les niveaux</h2>
      <div class="flex justify-center">
          <div class="flex flex-wrap justify-center w-220">
            <div v-for="level in levels" :key="level.id" class="w-full sm:w-1/2 p-6">
                <LevelCard :title="level.title" :subtitle="level.subtitle" :description="level.description" :id="level.id" />
            </div>
          </div>
      </div>
    </section>
  </template>
  

<script setup lang="ts">
import { ref } from 'vue';
import LevelCard from './LevelCard.vue';
import type Serie from '../../interface/serie.interface';

const levels = ref<Serie[]>([
    { title: 'A1', subtitle: 'Débutant', description: 'Ce niveau est destiné aux personnes qui commencent tout juste à apprendre l’anglais. L’accent est mis sur le vocabulaire de base, la grammaire élémentaire et la compréhension de phrases simples. L’objectif est de pouvoir se présenter, poser des questions courantes et comprendre des conversations très basiques.', id: '1' },
    { title: 'A2', subtitle: 'Élémentaire', description: 'À ce niveau, les apprenants peuvent déjà comprendre et utiliser des expressions courantes de la vie quotidienne. Les exercices aident à construire des phrases plus complexes, à parler de ses expériences et à interagir dans des situations courantes (restaurant, voyages, achats).', id: '2' },
    { title: 'B1', subtitle: 'Intermédiaire', description: 'Ce niveau permet de s’exprimer avec plus d’aisance sur des sujets variés. On y apprend à raconter des événements passés, exprimer son opinion et comprendre des textes et des dialogues plus élaborés. Idéal pour ceux qui veulent devenir autonomes dans des conversations du quotidien.', id: '3' },
    { title: 'B2', subtitle: 'Avancé', description: 'Les apprenants à ce niveau peuvent comprendre et produire des textes et discours plus complexes. On travaille ici sur l’argumentation, les idiomes, l’anglais des médias et les discussions approfondies. L’objectif est d’avoir une communication fluide et nuancée.', id: '4' },
    { title: 'C1', subtitle: 'Autonome', description: 'Ce niveau s’adresse aux personnes qui maîtrisent déjà bien l’anglais et souhaitent affiner leur compréhension et leur expression. On y travaille la subtilité de la langue, l’anglais académique et professionnel, ainsi que l’analyse de contenus authentiques comme des conférences ou des articles spécialisés.', id: '5' },
]);

</script>