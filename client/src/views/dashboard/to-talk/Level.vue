<template>
  <div class="flex flex-row flex-wrap">
    <router-view></router-view>
    <div
      class="rounded-b-4xl rounded-t-4xl overflow-x-hidden shadow-lg w-full bg-white py-8 lg:flex-1 mb-8 lg:mb-0"
    >
      <div class="overflow-x-hidden px-8 h-120 [&>*:nth-child(2)]:mt-3">
        <h3 class="text-gray-600 font-bold text-lg uppercase">Séries</h3>
        <SerieButton
          v-for="serie in computedSeries"
          :key="serie.id"
          :serie="serie"
        />
        <p v-if="series.length == 0" class="italic text-gray-400">
          Aucune série trouvée
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref, watch } from "vue";
import { Database } from "../../../utils/database.utils";
import { useRouter } from "vue-router";
import { useRoute } from "vue-router";
import ExercisesSerie from "../../../interface/exercises-serie.interface";
import UserCompletedExercisesSerie from "../../../interface/user-completed-exercises-serie.interface";
import store from "../../../store";
import SerieButton from "../../../components/Dashboard/Button/SerieButton.vue";
const router = useRouter();
const props = defineProps<{
  levelTitle: string;
  serieId?: string;
}>();
const route = useRoute();
const isLoading = ref(false);
const userId: string = store.getters.getUser.id;
const series = ref<ExercisesSerie[]>([]);
const firstSerie = ref<ExercisesSerie>();

const fetchLevel = async () => {
  try {
    isLoading.value = true;
    const { data } = await Database.get(
      `level/title/${props.levelTitle}?type=TALK`
    );
    series.value = data.exercisesSeries;
    store.commit("setExercisesSeries", data.exercisesSeries);
    firstSerie.value = getFirstSerie();
  } catch (error) {
    console.error("Erreur lors du chargement du niveau:", error);
  } finally {
    isLoading.value = false;
  }
};

const getFirstSerie = (): ExercisesSerie => {
  if (series.value) {
    const filteredSeriesByCompletion: ExercisesSerie = series.value.filter(
      (serie: ExercisesSerie) => {
        const userCompletedExercisesSerie: UserCompletedExercisesSerie =
          serie.completedUsers.find(
            (completedUser: UserCompletedExercisesSerie) => {
              return completedUser.userId === userId;
            }
          );
        return userCompletedExercisesSerie ? false : true;
      }
    )[0];
    return filteredSeriesByCompletion;
  }
};

const navigateToSerie = async () => {
  await fetchLevel();
  if ((!firstSerie.value && !series.value[0]) || props.serieId) return;
  router.push({
    name: "TalkSerie",
    params: { serieId: firstSerie.value?.id ?? series.value[0].id },
  });
};

watch(
  () => route.query,
  async () => {
    navigateToSerie();
  }
);

onMounted(async () => {
  navigateToSerie();
});

const computedSeries = computed(() => {
  return store.getters.getExercisesSeries;
});
</script>
