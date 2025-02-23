import api from '../../utils/api.utils';
import Cookies from 'js-cookie';
import { isTokenExpired, clearCookies } from '../../utils/auth.utils';
import type { User } from '../../interface/user.interface';
import { subscriberService } from '../../services/subscriber.service';
import Database from '../../utils/database.utils';

interface AuthResponse {
  access_token: string;
  refresh_token: string;
  payload: User;
}

interface AuthState {
  token: string | null;
  refreshToken: string | null;
  user: User | null;
  userLoggedIn: boolean;
}

const state: AuthState = {
  token: Cookies.get('access') || null,
  refreshToken: Cookies.get('refresh') || null,
  user: Cookies.get('user') ? JSON.parse(Cookies.get('user') as string) : null,
  userLoggedIn: !!Cookies.get('access'),
};

const mutations = {
  setToken(state: AuthState, token: string) {
    state.token = token;
  },
  setRefreshToken(state: AuthState, refreshToken: string) {
    state.refreshToken = refreshToken;
  },
  setUser(state: AuthState, user: any) {
    state.user = user;
  },
  setAuth(state: AuthState, status: boolean) {
    state.userLoggedIn = status;
  },
  clearAuthData(state: AuthState) {
    state.token = null;
    state.refreshToken = null;
    state.user = null;
    state.userLoggedIn = false;
  },
};

const actions = {
  async login({ commit }: any, { email, password }: { email: string, password: string }) {
    try {
      const response = await api.post<AuthResponse>('/auth/login', { email, password });
      const { access_token, refresh_token, payload } = response.data;
      commit('setToken', access_token);
      commit('setRefreshToken', refresh_token);
      commit('setUser', payload);
      commit('setAuth', true);
      Cookies.set('access', access_token, { secure: true, sameSite: 'strict' });
      Cookies.set('refresh', refresh_token, { secure: true, sameSite: 'strict' });
      Cookies.set('user', JSON.stringify(payload), { secure: true, sameSite: 'strict' });
    } catch (error) {
      console.error('Login failed:', error);
      throw error;
    }
  },
  async refreshToken({ commit, state }: any) {
    try {
      const response = await api.post<AuthResponse>('/auth/refresh', { refresh_token: state.refreshToken });
      const { access_token } = response.data;
      commit('setToken', access_token);
      Cookies.set('access', access_token, { secure: true, sameSite: 'strict' });
    } catch (error) {
      console.error('Token refresh failed:', error);
      commit('clearAuthData');
      clearCookies();
      throw error;
    }
  },
  async logout({ commit, state }: any) {
    try {
      await api.post('/auth/logout', { refresh_token: state.refreshToken });
      commit('clearAuthData');
      clearCookies();
    } catch (error) {
      console.error('Logout failed:', error);
      throw error;
    }
  },
  async initLogin({ dispatch, commit, state }: any) {
    const token = state.token;
    let isLoggedIn = false;
    const isUserFirstConnection = state.user.firstTimeConnection;
    if(!isUserFirstConnection){
      console.log('First time connected');
      await Database.update('auth/first-time-connected', '', {});
    }
    if (token && !isTokenExpired(token)) {
      isLoggedIn = true;
      subscriberService.subscribe();
    } else {
      const refresh = state.refreshToken;
      if (refresh) {
        try {
          await dispatch('refreshToken');
          isLoggedIn = true;
        } catch (error) {
          commit('clearAuthData');
        }
      }
    }

    commit('setAuth', isLoggedIn);
    return isLoggedIn;
  },
};

const getters = {
  isAuthenticated(state: AuthState): boolean {
    return !!state.token;
  },
  getToken(state: AuthState): string | null {
    return state.token;
  },
  getRefreshToken(state: AuthState): string | null {
    return state.refreshToken;
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