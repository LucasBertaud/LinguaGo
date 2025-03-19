<template>
  <div
    id="talk-card"
    class="rounded-b-4xl rounded-t-4xl shadow-lg overflow-hidden"
  >
    <div id="header-talk-card" class="bg-gray-100 p-8 pb-0 flex-row relative">
      <div class="flex flex-col">
        <h2 class="text-black font-semibold text-xl">
          Exercise {{ currentExerciseIndex + 1 }}/{{ serie.exercises.length }}
        </h2>
        <p class="text-gray-600 text-sm mt-2 text-pretty">
          Répétez la phrase en anglais quand vous cliquerez sur le bouton
          démarrer :
        </p>
        <p class="text-black font-bold italic mb-4">
          "{{ currentExercise?.answer }}"
        </p>
      </div>
      <FavoriteButton
        :serie-id="serie.id"
        :user-favorite-serie="userFavoriteSerie"
      />
    </div>
    <div id="body-talk-card" class="bg-gray-100 p-8 rounded-b-4xl">
      <div class="flex flex-row items-center">
        <button
          class="bg-white w-16 h-16 flex justify-center items-center rounded-full group active:scale-95 hover:scale-110 cursor-pointer transition relative"
          @click="handlePlay"
        >
          <Icon
            v-if="!isPlaying"
            svg-path="/assets/images/icons/play.svg"
            :options="{
              dynamicClasses: '[&>svg]:w-6 [&>svg]:h-6 [&>svg]:fill-black',
            }"
          />
          <Icon
            v-else
            svg-path="/assets/images/icons/stop.svg"
            :options="{
              dynamicClasses: '[&>svg]:w-7 [&>svg]:h-7 [&>svg]:fill-black',
            }"
          />
          <Icon
            class="opacity-0 transition-all"
            :class="isPlaying ? 'opacity-100' : 'opacity-0'"
            svg-path="/assets/images/icons/spin.svg"
            :options="{
              dynamicClasses: `
                                [&>svg]:absolute
                                [&>svg]:top-1/2
                                [&>svg]:left-1/2
                                [&>svg]:-translate-x-1/2
                                [&>svg]:-translate-y-1/2
                                [&>svg>path]:fill-white
                                [&>svg>path]:last:fill-secondary
                                [&>svg]:animate-spin
                                [&>svg]:w-28
                                [&>svg]:h-28
                            `,
            }"
          />
        </button>
        <p class="ml-8 text-gray-600 italic font-bold" v-if="answer">
          "{{ answer }}"
        </p>
      </div>
    </div>
    <div id="footer-talk-card" class="bg-white flex flex-row p-8">
      <div class="flex flex-row items-center mx-5 first:ml-0 last:mr-0">
        <div
          class="bg-secondary-light w-12 h-12 flex justify-center items-center rounded-2xl mr-4"
        >
          <Icon
            svg-path="/assets/images/icons/star.svg"
            :options="{
              dynamicClasses: '[&>svg]:w-6 [&>svg]:h-6 [&>svg]:fill-secondary',
            }"
          />
        </div>
        <div>
          <p class="font-bold text-xl">{{ pointsPerExo }}</p>
          <h3 class="text-gray-400 font-semibold uppercase">Points</h3>
        </div>
      </div>
      <div class="flex flex-row items-center mx-5">
        <div
          class="bg-primary-light w-12 h-12 flex justify-center items-center rounded-2xl mr-4"
        >
          <Icon
            svg-path="/assets/images/icons/clock.svg"
            :options="{
              dynamicClasses: '[&>svg]:w-6 [&>svg]:h-6 [&>svg]:stroke-primary',
            }"
          />
        </div>
        <div>
          <TimerSeconds color="gray" custom-class="font-bold text-xl" />
          <h3 class="text-gray-400 font-semibold uppercase">Temps</h3>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import Icon from "../../Icon.vue";
import FavoriteButton from "../Button/FavoriteButton.vue";
import ExercisesSerie from "../../../interface/exercises-serie.interface";
import UserFavoriteSerie from "../../../interface/user-favorite-serie.interface";
import store from "../../../store";
import TimerSeconds from "../Exercises/TimerSeconds.vue";
import Exercise from "../../../interface/exercise.interface";
import { ExercisesService } from "../../../services/exercises.service";
import { networkObserver } from "../../../services/network-observer";
import {
  methods,
  OfflineStorageService,
} from "../../../services/offline-storage.service";
import { Database } from "../../../utils/database.utils";
import { sanitize } from "../../../utils/sanitize.utils";
import numWords from "num-words";

const { serie, pointsPerExo } = defineProps<{
  serie: ExercisesSerie;
  pointsPerExo: number;
}>();
const userId = store.getters.getUser.id;
const userFavoriteSerie: UserFavoriteSerie | undefined =
  serie.favoriteUsers.find(
    (favorite) => favorite.userId === userId && favorite.serieId === serie.id
  );

const isPlaying = ref(false);
const currentExercise = ref<Exercise>();
const currentExerciseIndex = ref<number>(0);
const completedExercises = ref<Exercise[]>([]);
const answer = ref<string>("");
const isAlreadyCompleted = ref<boolean>(serie.completedUsers.length > 0);
const exercisesService = ref<ExercisesService | null>(null);
const recognition = ref(null);
const emit = defineEmits<{
  completed: [boolean];
}>();

const initVocal = () => {
  const SpeechRecognition =
    (window as any).SpeechRecognition ||
    (window as any).webkitSpeechRecognition;
  const SpeechGrammarList =
    (window as any).SpeechGrammarList ||
    (window as any).webkitSpeechGrammarList;

  const grammar =
    "#JSGF V1.0; grammar phrase; public <phrase> = " +
    serie.exercises.map((exercise: Exercise) => exercise.answer).join(" | ") +
    " ;";

  const recognition = new SpeechRecognition();
  const speechRecognitionList = new SpeechGrammarList();
  speechRecognitionList.addFromString(grammar, 1);
  recognition.grammars = speechRecognitionList;
  recognition.lang = "en-US";
  recognition.interimResults = true;
  recognition.continuous = true;

  return recognition;
};
const handlePlay = () => {
  isPlaying.value = !isPlaying.value;
  if (isPlaying.value) {
    recognition.value.start();
    let timer = null;
    recognition.value.onresult = (e: any) => {
      clearTimeout(timer);
      const lastIndex: number = e.results.length - 1;
      const transcript: string = e.results[lastIndex][0].transcript;
      timer = setTimeout(() => {
        answer.value = transcript.toLowerCase().trim();
        if (answer.value === "") return;
        isAnswerCorrect();
      }, 1000);
    };
    recognition.value.onend = () => {
      isPlaying.value = false;
    };
  } else {
    recognition.value.stop();
  }
};

const isAnswerCorrect = async () => {
  const splitedAnswer = answer.value.split(" ");
  const sanitizedAnswerWords = splitedAnswer.map((word) => {
    let sanitizeWord = sanitize(word);
    const wordToNumber = parseInt(sanitizeWord);

    if (!isNaN(wordToNumber)) {
      sanitizeWord = numWords(parseInt(sanitizeWord));
    }

    return sanitizeWord;
  });

  const splitedExerciseAnswer = currentExercise.value.answer.split(" ");
  const sanitizeExerciseAnswerWords = splitedExerciseAnswer.map((word) =>
    sanitize(word)
  );

  const filterAnswerWords = sanitizedAnswerWords.filter((word) =>
    sanitizeExerciseAnswerWords.includes(word)
  );
  const isCorrect: boolean = sanitizeExerciseAnswerWords.every((word) =>
    filterAnswerWords.includes(word)
  );
  console.log(isCorrect, filterAnswerWords, sanitizeExerciseAnswerWords);

  console.log(`isCorrect: ${isCorrect}`);
  if (isCorrect) {
    correct();
  } else {
    incorrect();
  }
};

const correct = async () => {
  exercisesService.value
    .markExerciseAsCompleted(currentExercise.value, completedExercises.value)
    .then((_) => {
      if (!completedExercises.value.includes(currentExercise.value)) {
        completedExercises.value.push(currentExercise.value);
        store.dispatch("updateSerie", serie.id);
      }
    })
    .finally(() => {
      if (currentExerciseIndex.value == serie.exercises.length - 1) {
        isCompleted();
        return;
      } else {
        nextExercise();
      }
    });
};

const incorrect = async () => {
  if (isAlreadyCompleted.value) return;
  exercisesService.value
    .markExerciseAsFailed(currentExercise.value, completedExercises.value)
    .then((_) => {
      if (completedExercises.value.includes(currentExercise.value)) {
        completedExercises.value = completedExercises.value.filter(
          (exercise: Exercise) => exercise.id !== currentExercise.value.id
        );
      }
    });
};

const isCompleted = () => {
  if (!isAlreadyCompleted.value) stampInDatabase();
  emit("completed", true);
};

const nextExercise = () => {
  currentExerciseIndex.value++;
  currentExercise.value = serie.exercises[currentExerciseIndex.value];
};

const stampInDatabase = async () => {
  try {
    if (networkObserver.isOffline()) {
      const data: object = {
        userId: userId,
        serieId: serie.id,
      };
      OfflineStorageService.store(
        "user-completed-exercises-serie",
        data,
        methods.POST
      );
      return;
    }
    await Database.post("user-completed-exercises-serie", {
      userId: userId,
      serieId: serie.id,
    });
    isAlreadyCompleted.value = true;
  } catch (error) {
    console.error(error);
  }
};

onMounted(() => {
  exercisesService.value = new ExercisesService(userId, serie.id);
  exercisesService.value.setPointsPerExo(pointsPerExo);
  completedExercises.value = serie.exercises.filter(
    (exercise: Exercise) => exercise?.usersCompleted?.length > 0
  );
  currentExercise.value = serie.exercises[currentExerciseIndex.value];
  recognition.value = initVocal();
});
</script>
