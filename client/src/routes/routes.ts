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
    {
      path: '/register',
      name: 'Register',
      component: () => import('../views/auth/Register.vue'),
    },
    {
      path: '/profile',
      name: 'Profile',
      component: () => import('../views/auth/Profile.vue'),
      meta: { requiresAuth: true },
    },
  ];
  
  export default routes;