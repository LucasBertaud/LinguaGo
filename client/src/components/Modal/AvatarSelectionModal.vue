<template>
  <Transition name="modal">
    <div
      v-if="isOpen"
      class="fixed inset-0 z-[60] overflow-y-auto"
      aria-labelledby="modal-title"
      role="dialog"
      aria-modal="true"
    >
      <div
        class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center"
      >
        <div class="fixed inset-0" @click="close">
          <div class="absolute inset-0 bg-gray-500/50"></div>
        </div>

        <div
          class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg w-full"
        >
          <div class="bg-white px-4 pt-5 pb-4 sm:p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">
              Choisir un avatar
            </h3>
            <div class="max-h-[60vh] overflow-y-auto">
              <div class="grid grid-cols-3 gap-4 p-4">
                <button
                  v-for="avatar in avatars"
                  :key="avatar.id"
                  @click="selectAvatar(avatar.id)"
                  class="flex items-center justify-center cursor-pointer p-2 rounded-lg hover:bg-gray-100 transition-colors duration-200 border border-gray-200"
                  :class="{
                    'bg-primary/10 border-primary':
                      avatar.id === userInfo?.avatarId,
                  }"
                >
                  <div
                    class="flex items-center justify-center [&>svg]:h-20 [&>svg]:w-20"
                    v-html="sanitizeAvatar(avatar.svg)"
                  ></div>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </Transition>
  <LoadingSpinner v-if="isLoading" />
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from "vue";
import DOMPurify from "dompurify";
import { useStore } from "vuex";
import { useToast } from "vue-toastification";
import type { Avatar } from "../../interface/avatar.interface";
import { Database } from "../../utils/database.utils";
import LoadingSpinner from "../../components/LoadingSpinner.vue";

const avatars = ref<Avatar[]>([]);

defineProps<{
  isOpen: boolean;
}>();

const emit = defineEmits<{
  (e: "close"): void;
  (e: "update"): void;
}>();

const store = useStore();
const toast = useToast();
const isLoading = ref(false);
const userInfo = computed(() => store.getters.getUser);

const loadAvatars = async () => {
  try {
    const { data } = await Database.get("avatar");
    if (data) {
      avatars.value = data;
    }
  } catch (error) {
    console.error("Error loading avatars:", error);
    toast.error("Erreur lors du chargement des avatars");
  }
};

const selectAvatar = async (avatarId: number) => {
  try {
    isLoading.value = true;
    await store.dispatch("updateUserProfile", { avatarId });

    toast.success("Avatar mis à jour avec succès");
    emit("update");
    emit("close");
  } catch (error) {
    toast.error("Erreur lors de la mise à jour de l'avatar");
  } finally {
    isLoading.value = false;
  }
};

const sanitizeAvatar = (svg: string) => {
  return DOMPurify.sanitize(svg);
};

const close = () => {
  emit("close");
};

onMounted(() => {
  loadAvatars();
});
</script>
