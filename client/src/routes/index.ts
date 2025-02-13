import { createRouter, createWebHistory } from 'vue-router';
import routes from './routes';
import store from '../store';

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  const isAuthenticated = store.state.auth.userLoggedIn;

  if (to.matched.some(record => record.meta.requiresAuth)) {
    // Route requires authentication
    if (isAuthenticated) {
      next();
    } else {
      next({ path: '/login' });
    }
  } else {
    next();
  }
});

export default router;