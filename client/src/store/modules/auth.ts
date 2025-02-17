import api from '../../utils/api.utils';
import Cookies from 'js-cookie';
import { isTokenExpired, clearCookies } from '../../utils/auth.utils';
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
      commit('setUser', payload);
      commit('setAuth', true);
      Cookies.set('user', JSON.stringify(payload), { secure: true, sameSite: 'strict' });
    } catch (error) {
      console.error('Login failed:', error);
      throw error;
    }
  },
  async refreshToken({ commit }: any) {
    try {
      const response = await api.post<AuthResponse>('/auth/refresh');
      const { payload } = response.data;
      commit('setUser', payload);
      Cookies.set('user', JSON.stringify(payload), { secure: true, sameSite: 'strict' });
    } catch (error) {
      console.error('Token refresh failed:', error);
      commit('clearAuthData');
      clearCookies();
      throw error;
    }
  },
  async updateUser({ commit, state }: any, userData: any) {
    try {
      const updatedUser = {
        id: state.user?.id,
        email: userData.email,
        role: userData.role,
        pseudo: userData.pseudo,
        avatarId: userData.avatarId,
      };

      commit('setUser', updatedUser);

      Cookies.set('user', JSON.stringify(updatedUser), {
        secure: true,
        sameSite: 'strict'
      });

      const currentToken = Cookies.get('access');
      if (currentToken) {
        Cookies.set('access', currentToken, {
          secure: true,
          sameSite: 'strict'
        });
      }
    } catch (error) {
      console.error('Update user failed:', error);
      throw error;
    }
  },
  async logout({ commit }: any) {
    try {
      await api.post('/auth/logout');
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