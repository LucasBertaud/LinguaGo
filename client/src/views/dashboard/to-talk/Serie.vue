<template>
    <div class="mb-8 w-full lg:mb-0 lg:w-[55%] lg:mr-16">
        <TalkExerciseCard v-if="serie && !serieCompleted" :serie="serie" :points-per-exo="serie.level.pointsPerExo" :key="serie.id" />
        <div v-else class="bg-white rounded-b-4xl rounded-t-4xl shadow-lg overflow-hidden p-8 w-100 mx-auto my-auto">
            <div class="flex flex-col w-full justify-center items-center">
                <Icon class="mb-4" svg-path="/assets/images/icons/achievement.svg" :options="{ dynamicClasses: '[&>svg]:w-26 [&>svg]:h-26 [&>svg]:fill-secondary' }" />
                <h3 class="text-gray-600 font-bold text-lg uppercase mb-2">Félicitations !</h3>
                <p class="text-gray-400 italic">Vous avez terminé cette série avec succés.</p>
                <p class="text-gray-400 italic">Passez à la prochaine série.</p>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref, watch } from 'vue';
import TalkExerciseCard from '../../../components/Dashboard/Card/TalkExerciseCard.vue';
import ExercisesSerie from '../../../interface/exercises-serie.interface';
import Database from '../../../utils/database.utils';
import { useRoute } from 'vue-router';
import store from '../../../store';
import Icon from '../../../components/Icon.vue';

const serie = ref<ExercisesSerie>(null);
const serieCompleted = ref<boolean>(false);
const route = useRoute();
const props = defineProps<{
    serieId: string;
}>();

const fetchSerie = async () => {
    try {
        const data = await Database.getAll(`exercises-serie/${props.serieId}`);
        serie.value = data;
        console.log('Série chargée:', serie.value);
    } catch (error) {
        console.error('Erreur lors du chargement de la série:', error);
    }
}

const isSerieCompleted = (): boolean => serie.value.completedUsers.some((completedUser) => completedUser.userId === store.getters.getUser.id);

watch(() => route.query, async () => {
    await fetchSerie();
    serieCompleted.value = isSerieCompleted();
});

onMounted(async () => {
    await fetchSerie();
    serieCompleted.value = isSerieCompleted();
});
</script>