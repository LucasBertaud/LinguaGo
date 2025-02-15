const routes = [
    {
      path: '/',
      name: 'Home',
      component: () => import('../views/Home.vue'),
    },
    {
      path: '/levels',
      name: 'Levels',
      component: () => import('../views/Levels.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/levels/:level',
      name: 'Exercises',
      component: () => import('../components/ExerciseList.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/login',
      name: 'Login',
      component: () => import('../views/auth/Login.vue'),
    },
  ];
  
  export default routes;