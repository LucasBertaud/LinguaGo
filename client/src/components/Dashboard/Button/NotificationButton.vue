<template>
  <Popper
    arrow
    class="mr-4"
    @open:popper="handleOpen"
    v-if="!isNotificationBlocked"
  >
    <button
      class="relative p-2 text-white hover:bg-gray-100 hover:text-gray-600 focus:bg-gray-100 focus:text-gray-600 rounded-full cursor-pointer"
    >
      <span class="sr-only">Notifications</span>
      <svg
        aria-hidden="true"
        fill="none"
        viewBox="0 0 24 24"
        stroke="currentColor"
        class="h-6 w-6"
      >
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
        />
      </svg>
    </button>
    <template #content>
      <div class="flex flex-col w-64">
        <label class="inline-flex items-center cursor-pointer">
          <input
            type="checkbox"
            @change="handleCheckbox"
            :checked="areNotificationsActivate"
            class="sr-only peer"
          />
          <div
            class="relative w-11 h-6 bg-gray-300 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-primary-light rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"
          ></div>
          <span class="ms-3 text-sm font-medium text-black">{{
            areNotificationsActivate
              ? "Enlever les notifications"
              : "Ajouter les notifications"
          }}</span>
        </label>
        <div v-if="areNotificationsActivate">
          <div
            class="mb-4 relative after:content-[''] after:absolute after:-top-4 after:w-full after:h-[1px] after:bg-gray-300 mt-8"
          >
            <label
              for="frequency"
              class="block mb-2 text-sm font-medium text-black"
              >À quelle heure ?</label
            >
            <VueDatePicker
              auto-apply
              v-model="time"
              @update:model-value="
                handleUpdate({
                  notificationTime: `${time.hours}:${time.minutes}`,
                })
              "
              time-picker
              inline
              :startTime="startTime"
            />
          </div>
          <div>
            <label
              for="frequency"
              class="block mb-2 text-sm font-medium text-black"
              >Tous les combiens de jours ?</label
            >
            <select
              @change="handleUpdate({ frequency: frequency })"
              v-model="frequency"
              name="frequency"
              class="bg-white border border-gray-300 text-black text-sm rounded-lg focus:ring-primary focus:border-primary block w-full p-2.5"
            >
              <option
                v-for="days in FrequencyNotification"
                :value="getEnumKeyByValue(FrequencyNotification, days)"
              >
                {{ days }}
              </option>
            </select>
          </div>
        </div>
      </div>
    </template>
  </Popper>
</template>

<script setup lang="ts">
import Popper from "vue3-popper";
import { ref } from "vue";
import { Database } from "../../../utils/database.utils";
import { subscriberService } from "../../../services/subscriber.service";
import VueDatePicker from "@vuepic/vue-datepicker";
import "@vuepic/vue-datepicker/dist/main.css";
import { getEnumKeyByValue } from "../../../utils/enum.utils";
import { SubscriptionInterface } from "../../../interface/subscription.interface";

enum FrequencyNotification {
  TODAY = "Juste aujourd'hui",
  ONE_DAY = "Un jour",
  TWO_DAYS = "Deux jours",
  THREE_DAYS = "Trois jours",
  FOUR_DAYS = "Quatre jours",
  FIVE_DAYS = "Cinq jours",
  SIX_DAYS = "Six jours",
  SEVEN_DAYS = "Une semaine",
}

const isNotificationBlocked = ref<boolean>(
  Notification.permission === "denied"
);
const areNotificationsAllowed = ref<boolean>(false);
const areNotificationsActivate = ref<boolean>(false);
const time = ref();
const startTime = ref({ hours: 0, minutes: 0 });
const timerUpdate = ref();
const frequency = ref();
const isNotificationFetched = ref(false);

const handleUpdate = async (data: object) => {
  if (timerUpdate.value) clearTimeout(timerUpdate.value);
  timerUpdate.value = setTimeout(async () => {
    await Database.patch("notification", data);
  }, 1000);
};

const handleOpen = async () => {
  areNotificationsAllowed.value =
    Notification && Notification.permission === "granted";
  if (areNotificationsAllowed.value) {
    fetchNotificationInDatabase();
  }
};

const fetchNotificationInDatabase = async () => {
  const { data } = await Database.get("notification/user");
  if (!data) return (isNotificationFetched.value = false);
  areNotificationsActivate.value = data.isActivate;
  const notificationTime = data.notificationTime;
  const splitTime = notificationTime?.split(":");
  const date = new Date();
  date.setHours(parseInt(splitTime[0]));
  date.setMinutes(parseInt(splitTime[1]));
  startTime.value = { hours: date.getHours(), minutes: date.getMinutes() };
  frequency.value = data.frequency;
  isNotificationFetched.value = true;
};

const handleCheckbox = async (): Promise<void> => {
  if (!areNotificationsAllowed.value) {
    await createNotification();
  } else {
    if (isNotificationFetched.value) {
      await handleUpdate({ isActivate: !areNotificationsActivate.value });
      areNotificationsActivate.value = !areNotificationsActivate.value;
    } else {
      await createNotification();
    }
  }
};

const createNotification = async () => {
  const subscription: SubscriptionInterface | void =
    await subscriberService.subscribe();
  isNotificationBlocked.value = Notification.permission === "denied";
  if (!subscription) return;
  areNotificationsAllowed.value = subscription.isActivate;
  areNotificationsActivate.value = subscription.isActivate;
};
</script>

<style lang="css" scoped>
:deep(.dp__action_row) {
  display: none;
}
:deep(div.dp__overlay.dp--overlay-relative) {
  height: 8rem !important;
}
</style>
