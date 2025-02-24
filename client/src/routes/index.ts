import { createRouter, createWebHistory } from 'vue-router';
import routes from './routes';
import store from '../store';

interface RootState {
  auth: {
    userLoggedIn: boolean;
  };
}

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  const isAuthenticated = (store.state as RootState).auth.userLoggedIn;

  const requiresAuth = to.matched.some(record => record.meta.requiresAuth);
  const requiresGuest = to.matched.some(record => record.meta.requiresGuest);

  if (requiresAuth && !isAuthenticated) {
    next({ name: 'Login' });
    return;
  }

  if (requiresGuest && isAuthenticated) {
    next({ name: 'Dashboard' });
    return;
  }

  next();
});

export default router;