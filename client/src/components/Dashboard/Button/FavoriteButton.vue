<template>
    <button class="transition absolute top-6 right-6 z-10">
        <Icon
        v-on:click="handleFavorite"
        v-on:keyup.enter="handleFavorite"
        tabindex="0"
        svg-path="/assets/images/icons/heart-filled.svg" 
        :options="{
            dynamicClasses: `
            opacity-20
            transition
            hover:!opacity-50
            focus-visible:opacity-50
            active:[&>svg>*]:fill-red-700
            [&>svg]:w-7 
            [&>svg]:h-auto
            [&>svg>*]:fill-gray-600
            ${isFavoriteActivate && '[&>svg>*]:fill-red-600 !opacity-100'}
            `,
        }" />
    </button>
</template>

<script setup lang="ts">
import Database from '../../../utils/database';
import store from '../../../store';
import { ref } from 'vue';
import type UserFavoriteSerie from '../../../interface/user-favorite-serie.interface';
import Icon from '../../Icon.vue';

const props = defineProps<{serieId: number, userFavoriteSerie?: UserFavoriteSerie}>();
const userId: string = store.getters.getUser.id;
const isFavoriteActivate = ref<boolean>(props.userFavoriteSerie ? true : false);
const emit = defineEmits<{
  removeFavorite: string[];
}>();


const handleFavorite = async () => {
  if (isFavoriteActivate.value) {
    await removeFavorite();
  } else {
    await addFavorite();
  }
}

const addFavorite = async () => {
  try {
    await Database.create('user-favorite-serie', { 
      userId: userId, 
      serieId: props.serieId 
    });
    isFavoriteActivate.value = true;
  } catch (error) {
    console.error(error);
  }
};

const removeFavorite = async () => {
  try {
    await Database.delete(`user-favorite-serie/${userId}/${props.serieId}`);
    isFavoriteActivate.value = false;
    emit('removeFavorite');
  } catch (error) {
    console.error(error);
  }
};
</script>