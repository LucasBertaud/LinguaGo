import api from '../../utils/api.utils';
import Cookies from 'js-cookie';
import type { User } from '../../interface/user.interface';
import { subscriberService } from '../../services/subscriber.service';
import Database from '../../utils/database.utils';
import { networkObserver } from '../../services/network-observer';

interface AuthState {
  user: User | null;
  userLoggedIn: boolean;
}

const state: AuthState = {
  user: Cookies.get('user') ? JSON.parse(Cookies.get('user') as string) : null,
  userLoggedIn: !!Cookies.get('user'),
};

const mutations = {
  setUser(state: AuthState, user: User) {
    state.user = user;
  },
  setAuth(state: AuthState, status: boolean) {
    state.userLoggedIn = status;
  },
  clearAuthData(state: AuthState) {
    state.user = null;
    state.userLoggedIn = false;
  },
};

const actions = {
  async login({ commit }: any, { email, password }: { email: string, password: string }) {
    try {
      await api.post('/auth/login', { email, password });
      const userCookie = Cookies.get('user');
      if (userCookie) {
        const user = JSON.parse(userCookie);
        commit('setUser', user);
        commit('setAuth', true);
        if(user.firstTimeConnection){
          Database.patch("auth/first-time-connected");
          subscriberService.subscribe();
        }
      }
    } catch (error) {
      console.error('Login failed:', error);
      throw error;
    }
  },
  
  async logout({ commit }: any) {
    try {
      await api.post('/auth/logout');
      commit('clearAuthData');
    } catch (error) {
      console.error('Logout failed:', error);
      commit('clearAuthData');
      throw error;
    }
  },
  
  initLogin({ commit }: any) {
    const userCookie = Cookies.get('user');
    if (!userCookie) {
      commit('clearAuthData');
      return false;
    }

    try {
      const user = JSON.parse(userCookie);
      commit('setUser', user);
      commit('setAuth', true);
      return true;
    } catch (error) {
      commit('clearAuthData');
      return false;
    }
  },

  async updateUserProfile({ commit }: any, updatedProfile: Partial<User>) {
    try {
      const response = await api.patch('/user', updatedProfile);
      commit('setUser', response.data);
      await api.post('/auth/refresh');
      return response.data;
    } catch (error) {
      console.error('Profile update failed:', error);
      throw error;
    }
  },
};

const getters = {
  isAuthenticated(state: AuthState): boolean {
    return state.userLoggedIn;
  },
  getUser(state: AuthState): any | null {
    if(networkObserver.isOffline()){
      return JSON.parse(localStorage.getItem('userOffline'));
    }
    return state.user;
  },
};

const auth = {
  state,
  mutations,
  actions,
  getters,
};

export default auth;