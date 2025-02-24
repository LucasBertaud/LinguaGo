<template>
    <Transition name="modal">
        <div v-if="isOpen" class="fixed inset-0 z-50 overflow-y-auto" aria-labelledby="modal-title" role="dialog"
            aria-modal="true">
            <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
                <!-- Simplified overlay -->
                <div class="fixed inset-0" @click="close">
                    <div class="absolute inset-0 bg-gray-500/50"></div>
                </div>

                <!-- Modal panel -->
                <div
                    class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg w-full mx-4 sm:w-full">
                    <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                        <div class="flex items-start">
                            <div class="mt-3 text-center sm:mt-0 sm:text-left w-full">
<<<<<<< HEAD
                                <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">Mon Profil</h3>
=======
                                <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4 text-center">Mon Profil</h3>
>>>>>>> d783c89a694dac33c9156fcc7b2200c063cf6f4e
                                <div class="flex flex-col space-y-4">
                                    <div class="flex flex-col items-center justify-center mb-4">
                                        <div class="h-20 w-20 rounded-full overflow-hidden bg-gray-100 mb-2">
                                            <div v-if="avatarSvg" v-html="sanitizedSvg"
                                                class="h-20 w-20 flex items-center justify-center">
                                            </div>
                                        </div>
                                        <button @click="openAvatarSelection"
<<<<<<< HEAD
                                            class="text-sm text-primary hover:text-primary-dark transition-colors duration-200 flex items-center gap-1">
=======
                                            class="text-sm text-primary hover:text-primary-dark transition-colors duration-200 flex items-center gap-1 cursor-pointer">
>>>>>>> d783c89a694dac33c9156fcc7b2200c063cf6f4e
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                                viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                                            </svg>
                                            Modifier l'avatar
                                        </button>
                                    </div>
                                    <div class="space-y-2">
                                        <p class="text-sm text-gray-500 text-center sm:text-left ml-2">Pseudo</p>
                                        <div class="group relative flex items-center gap-2">
                                            <input v-if="isEditing" type="text" v-model="editedPseudo"
                                                @keyup.enter="toggleEdit"
                                                class="w-full p-2 border-b-2 border-primary bg-gray-50/30 focus:outline-none focus:ring-0 rounded-md text-center sm:text-left"
                                                ref="pseudoInput" />
                                            <div v-else @click="toggleEdit"
                                                class="w-full flex items-center justify-between group bg-gray-50/30 p-2 rounded-md hover:bg-gray-100/50 transition-all duration-200 cursor-pointer">
                                                <p class="font-medium w-full text-center sm:text-left">{{
                                                    userInfo?.pseudo }}</p>
                                                <span
                                                    class="text-gray-400 group-hover:text-primary transition-colors duration-200">
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                                                    </svg>
                                                </span>
                                            </div>
                                            <button v-if="isEditing" @click="toggleEdit"
                                                class="absolute right-2 text-primary hover:text-primary-dark transition-colors">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M5 13l4 4L19 7" />
                                                </svg>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="space-y-2">
                                        <p class="text-sm text-gray-500 ml-2">Email</p>
                                        <p class="font-medium ml-2">{{ userInfo?.email }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                        <button type="button" @click="close"
                            class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm cursor-pointer">
                            Fermer
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </Transition>
    <AvatarSelectionModal :is-open="isAvatarSelectionOpen" @close="closeAvatarSelection" @update="close" />
    <LoadingSpinner v-if="isLoading" />
</template>

<script setup lang="ts">
import { computed, ref, watch } from 'vue';
import { useStore } from 'vuex';
import DOMPurify from 'dompurify';
import { useToast } from 'vue-toastification';
import Database from '../../utils/database.utils';
import AvatarSelectionModal from './AvatarSelectionModal.vue';
import LoadingSpinner from '../../components/LoadingSpinner.vue';

const props = defineProps<{
    isOpen: boolean
}>();

const emit = defineEmits<{
    (e: 'close'): void
}>();

const store = useStore();
const toast = useToast();
const isLoading = ref(false);
const userInfo = computed(() => store.getters.getUser);
const avatarSvg = ref('');

const isEditing = ref(false);
const editedPseudo = ref('');

const isAvatarSelectionOpen = ref(false);

const openAvatarSelection = () => {
    isAvatarSelectionOpen.value = true;
};

const closeAvatarSelection = () => {
    isAvatarSelectionOpen.value = false;
};

const toggleEdit = async () => {
    if (isEditing.value) {
        try {
            isLoading.value = true;
            const response = await Database.patch('user', {
                pseudo: editedPseudo.value
            });

            if (response) {
                // Mise à jour du store ET du cookie d'authentification
<<<<<<< HEAD
                await store.dispatch('updateUser', response);
=======
                store.commit('setUser', response);
>>>>>>> d783c89a694dac33c9156fcc7b2200c063cf6f4e
                
                toast.success('Pseudo mis à jour avec succès');
                isEditing.value = false;
            }
        } catch (error) {
            toast.error('Erreur lors de la mise à jour du pseudo');
        } finally {
            isLoading.value = false;
        }
    } else {
        editedPseudo.value = userInfo.value?.pseudo || '';
        isEditing.value = true;
    }
};

const loadAvatar = async () => {
  if (userInfo.value?.avatarId) {
    try {
      const avatar = await Database.getOne('avatar', userInfo.value.avatarId.toString());
      if (avatar) {
        avatarSvg.value = avatar.svg;
      }
    } catch (error) {
      console.error('Erreur lors du chargement de l\'avatar:', error);
      toast.error('Erreur lors du chargement de l\'avatar');
    }
  }
};

watch(() => userInfo.value?.avatarId, (newAvatarId) => {
  if (newAvatarId) {
    loadAvatar();
  } else {
    avatarSvg.value = '';
  }
}, { immediate: true });

const sanitizedSvg = computed(() => {
  if (!avatarSvg.value) return '';
  return DOMPurify.sanitize(avatarSvg.value);
});

const close = () => {
    isEditing.value = false;
    emit('close');
};
</script>

<style scoped>
.modal-enter-active,
.modal-leave-active {
    transition: opacity 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
    opacity: 0;
}
</style>