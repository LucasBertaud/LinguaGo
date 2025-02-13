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
      meta: { requiresAuth: true },
    },
    {
      path: '/levels/:levelId/exercises',
      name: 'Exercises',
      component: () => import('../components/ExerciseList.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/login',
      name: 'Login',
      component: () => import('../views/Login.vue'),
    },
  ];
  
  export default routes;