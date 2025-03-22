import { createRouter, createWebHistory } from 'vue-router';
import routes from './routes';
import store from '../store';
import { networkObserver } from '../services/network-observer';
import { OfflineStorageService } from '../services/offline-storage.service';

interface RootState {
  auth: {
    userLoggedIn: boolean;
  };
}

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, _, next) => {
  let isAuthenticated = false;
  if(!networkObserver.isOffline()){
    isAuthenticated = (store.state as RootState).auth.userLoggedIn;
  } else {
    isAuthenticated = Boolean(JSON.parse(localStorage.getItem('userOffline')));
  }
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

  if(isAuthenticated && !networkObserver.isOffline()){ 
    OfflineStorageService.releaseAllOfflineStorage();
  }

  next();
});

export default router;