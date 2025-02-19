const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue'),
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    meta: {
      dashboard: true,
      requiresAuth: true,
    },
    redirect: { name: 'DashboardHome' },
    children: [
      {
        path: 'home',
        name: 'DashboardHome',
        component: () => import('../views/dashboard/Dashboard.vue'),
      },
      {
        path: 'to-exercise',
        name: 'ToExercise',
        component: () => import('../views/dashboard/ToExercise.vue'),
        redirect: {
          name: 'LevelDetail',
          params: {
            levelTitle: 'A1'
          }
        },
        children: [
          {
            path: ':levelTitle',
            name: 'LevelDetail',
            props: true,
            component: () => import('../views/dashboard/Level.vue'),
            redirect: {
              name: 'Series',
            },
            children: [
              {
                name: 'Series',
                path: 'series',
                props: true,
                component: () => import('../views/dashboard/Series.vue'),
              },
              {
                name: 'Exercises',
                path: ':serieId',
                props: true,
                component: () => import('../views/dashboard/Exercises.vue'),
              }
            ]
          }
        ]
      },
      {
        name: 'Favorites',
        path: 'favorites',
        component: () => import('../views/dashboard/Favorites.vue'),
      }
    ]
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