import { RouteRecordRaw } from 'vue-router';

const routes: RouteRecordRaw[] = [
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
        path: 'to-talk',
        name: 'ToTalk',
        component: () => import('../views/dashboard/to-talk/Index.vue'),
        redirect: {
          name: 'TalkLevelDetail',
          params: {
            levelTitle: 'A1'
          }
        },
        children: [
          {
            path: ':levelTitle',
            name: 'TalkLevelDetail',
            props: true,
            component: () => import('../views/dashboard/to-talk/Level.vue'),
            children: [
              {
                name: 'TalkSerie',
                path: ':serieId',
                props: true,
                component: () => import('../views/dashboard/to-talk/Serie.vue'),
              }
            ]
          }
        ]
      },
      {
        path: 'to-exercise',
        name: 'ToExercise',
        component: () => import('../views/dashboard/to-exercise/Index.vue'),
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
            component: () => import('../views/dashboard/to-exercise/Level.vue'),
            redirect: {
              name: 'Series',
            },
            children: [
              {
                name: 'Series',
                path: 'series',
                props: true,
                component: () => import('../views/dashboard/to-exercise/Series.vue'),
              },
              {
                name: 'Exercises',
                path: ':serieId',
                props: true,
                component: () => import('../views/dashboard/to-exercise/Exercises.vue'),
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
    meta: {
      requiresGuest: true
    }
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/auth/Register.vue'),
    meta: {
      requiresGuest: true
    }
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: () => import('../views/NotFound.vue'),
  },
];

export default routes;