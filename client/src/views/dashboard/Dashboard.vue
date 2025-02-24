<template>
    <Title title="Accueil" />
    <section class="grid md:grid-cols-2 xl:grid-cols-4 gap-6">
        <SimpleStatCard 
            color="pink" 
            icon="mortarboard" 
            title="Niveau actuel" 
            :stats="userStats?.level || '0'"
            icon-classes="[&>svg]:w-6 [&>svg]:h-auto" 
        />
        <SimpleStatCard 
            color="yellow" 
            icon="point-outline" 
            :title="`${(userStats?.points || 0) > 1 ? 'Points gagnés' : 'Point gagné'}`" 
            :stats="`${userStats?.points || 0} / ${siteStats?.totalPoints || 0}`" 
            icon-classes="[&>svg>*]:stroke-current [&>svg]:w-7 [&>svg]:h-auto" 
        />
        <SimpleStatCard 
            color="blue" 
            icon="book-open" 
            :title="`${(userStats?.successfullExercises || 0) > 1 ? 'Exercises réussis' : 'Exercise réussi'}`" 
            :stats="`${userStats?.successfullExercises || 0} / ${siteStats?.totalExercises || 0}`"
            icon-classes="[&>svg]:w-6 [&>svg]:h-auto" 
        />
        <SimpleStatCard 
            color="green" 
            icon="completed" 
            :title="`${(userStats?.completedSeries || 0) > 1 ? 'Séries complétées' : 'Série complétée'}`" 
            :stats="`${userStats?.completedSeries || 0} / ${siteStats?.totalSeries || 0}`"
            icon-classes="[&>svg]:w-6 [&>svg]:h-auto [&>svg>*]:fill-current" 
        />
    </section>
    <section class="grid md:grid-cols-2 xl:grid-cols-4 xl:grid-rows-3 xl:grid-flow-col gap-6 mb-6">
        <ExercisesCompletedPerDaysStats />
        <SimpleStatCard 
            color="red" 
            icon="fail" 
            :title="`${(userStats?.failedExercises || 0) > 1 ? 'Exercises échoués' : 'Exercise échoué'}`" 
            :stats="`${userStats?.failedExercises || 0}`"
            icon-classes="[&>svg]:w-7 [&>svg]:h-auto [&>svg>*]:fill-current"
        />
        <SimpleStatCard 
            color="teal" 
            icon="clock" 
            :title="`${timeStats?.getBestTimeTitle() || 'Temps'} passé sur les exercices`" 
            :stats="`${timeStats?.getBestTimeUnit() || '0'}`"
            icon-classes="[&>svg]:w-6 [&>svg]:h-auto" 
        />
        <TopUsersOfWeekStats />
        <SeriesCompletedStats />
    </section>
    <LoadingSpinner v-if="isLoading" />
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import SimpleStatCard from '../../components/Dashboard/Card/SimpleStatCard.vue';
import Title from '../../components/Dashboard/Layout/Title.vue';
import Database from '../../utils/database.utils';
import TimeStatsUtils from '../../utils/stats/time-stats.utils';
import type UserStats from '../../interface/user-stats.interface';
import type SiteStats from '../../interface/site-stats.interface';
import ExercisesCompletedPerDaysStats from '../../components/Dashboard/Stats/ExercisesCompletedPerDaysStats.vue';
import SeriesCompletedStats from '../../components/Dashboard/Stats/SeriesCompletedStats.vue';
import TopUsersOfWeekStats from '../../components/Dashboard/Stats/TopUsersOfWeekStats.vue';
import LoadingSpinner from '../../components/LoadingSpinner.vue';

const userStats = ref<UserStats>();
const siteStats = ref<SiteStats>();
const timeStats = ref<TimeStatsUtils>();
const isLoading = ref(false);

const fetchUserStats = async () => {
    try {
        isLoading.value = true;
        const response = await Database.getAll('user-stats/user');
        timeStats.value = new TimeStatsUtils(response.timeSpentOnExercises);
        userStats.value = response;
    } catch (error) {
        console.error(error);
    }   finally {
        isLoading.value = false;
    }
}

const fetchSiteStats = async () => {
    try {
        isLoading.value = true;
        const response = await Database.getAll('site-stats');
        siteStats.value = response;
    } catch (error) {
        console.error(error);
    } finally {
        isLoading.value = false;
    }
}

onMounted(() => {
    fetchUserStats();
    fetchSiteStats();
});
</script>