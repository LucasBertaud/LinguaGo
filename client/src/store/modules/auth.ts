import api from '../../utils/api.utils';
import Cookies from 'js-cookie';
import type { User } from '../../interface/user.interface';
import { subscriberService } from '../../services/subscriber.service';
import Database from '../../utils/database.utils';

interface AuthResponse {
  payload: User;
}

interface AuthState {
  user: User | null;
  userLoggedIn: boolean;
}

const state: AuthState = {
  user: Cookies.get('user') ? JSON.parse(Cookies.get('user') as string) : null,
  userLoggedIn: !!Cookies.get('user'),
};

const mutations = {
  setUser(state: AuthState, user: any) {
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
      const response = await api.post<AuthResponse>('/auth/login', { email, password });
      const { payload } = response.data;
      if(payload.firstTimeConnection){
        const subscription = JSON.stringify(await subscriberService.subscribe());
        Database.create("notification", {
          userId: payload.id,
          isActivate: true,
          subscription: subscription
        });
        Database.patch("auth/first-time-connected").then(_ => payload.firstTimeConnection = false);
      }
      commit('setUser', payload);
      commit('setAuth', true);
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
      throw error;
    }
  },
  
  async initLogin({ commit }: any) {
    try {
      const response = await api.get('/auth/me');
      const { user } = response.data;
      commit('setUser', user);
      commit('setAuth', true);
      return true;
    } catch (error) {
      commit('clearAuthData');
      return false;
    }
  }
};

const getters = {
  isAuthenticated(state: AuthState): boolean {
    return state.userLoggedIn;
  },
  getUser(state: AuthState): any | null {
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