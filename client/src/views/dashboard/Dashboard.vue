<template>
    <Title title="Accueil" />
    <section class="grid md:grid-cols-2 xl:grid-cols-4 gap-6">
        <SimpleStatCard 
            v-if="userStats && siteStats" 
            color="yellow" 
            icon="point-outline" 
            :title="`${userStats.points > 1 ? 'Points gagnés' : 'Point gagné'}`" 
            :stats="`${userStats.points} / ${siteStats.totalPoints}`" 
            icon-classes="[&>svg>*]:stroke-current [&>svg]:w-7 [&>svg]:h-auto" />
            <SimpleStatCard 
            v-if="userStats && siteStats" 
            color="blue" 
            icon="book-open" 
            :title="`${userStats.successfullExercises > 1 ? 'Exercises réussis' : 'Exercise réussi'}`" 
            :stats="`${userStats.successfullExercises} / ${siteStats.totalExercises}`"
            icon-classes="[&>svg]:w-6 [&>svg]:h-auto" 
        />
        <SimpleStatCard 
            v-if="userStats && siteStats" 
            color="green" 
            icon="completed" 
            :title="`${userStats.completedSeries > 1 ? 'Séries complétés' : 'Série complété'}`" 
            :stats="`${userStats.completedSeries} / ${siteStats.totalSeries}`"
            icon-classes="[&>svg]:w-6 [&>svg]:h-auto [&>svg>*]:fill-current" 
        />
        <SimpleStatCard 
            v-if="userStats && siteStats" 
            color="red" 
            icon="fail" 
            :title="`${userStats.failedExercises > 1 ? 'Exercises échoués' : 'Exercise échoué'}`" 
            :stats="`${userStats.failedExercises}`"
            icon-classes="[&>svg]:w-7 [&>svg]:h-auto [&>svg>*]:fill-current"
        />
    </section>
    <section class="grid md:grid-cols-2 xl:grid-cols-4 xl:grid-rows-3 xl:grid-flow-col gap-6">
        <ExercisesCompletedPerDaysStats />
        <SimpleStatCard 
            v-if="userStats" 
            color="pink" 
            icon="mortarboard" 
            :title="`Niveau actuel`" 
            :stats="`${userStats.level}`"
            icon-classes="[&>svg]:w-6 [&>svg]:h-auto" />
            <SimpleStatCard 
            v-if="userStats && timeStats" 
            color="teal" 
            icon="clock" 
            :title="`${timeStats.getBestTimeTitle()} passé sur les exercices`" 
            :stats="`${timeStats.getBestTimeUnit()}`"
            icon-classes="[&>svg]:w-6 [&>svg]:h-auto" 
        />
        <TopUsersOfWeekStats />
        <SeriesCompletedStats />
    </section>
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

const userStats = ref<UserStats>();
const siteStats = ref<SiteStats>();
const timeStats = ref<TimeStatsUtils>();

const fetchUserStats = async () => {
    try {
        const response = await Database.getAll('user-stats/user');
        timeStats.value = new TimeStatsUtils(response.timeSpentOnExercises);
        userStats.value = response;
    } catch (error) {
        console.error(error);
    }
}

const fetchSiteStats = async () => {
    try {
        const response = await Database.getAll('site-stats');
        siteStats.value = response;
    } catch (error) {
        console.error(error);
    }
}

onMounted(() => {
    fetchUserStats();
    fetchSiteStats();
});
</script>