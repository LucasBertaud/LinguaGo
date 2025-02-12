const routes = [
    {
      path: '/',
      name: 'Home',
      component: () => import('../views/Home.vue'),
    },
    {
      path: '/levels',
      name: 'Levels',
      component: () => import('../components/LevelList.vue'),
    },
    {
      path: '/levels/:levelId/exercises',
      name: 'Exercises',
      component: () => import('../components/ExerciseList.vue'),
    }
  ];
  
  export default routes;