import api from '../../utils/api';
import jwtDecode from 'jwt-decode';
import Cookies from 'js-cookie';

interface AuthResponse {
  access_token: string;
  user: any;
}

interface AuthState {
  token: string | null;
  user: any | null;
  userLoggedIn: boolean;
}

const state: AuthState = {
  token: Cookies.get('access') || null,
  user: null,
  userLoggedIn: !!Cookies.get('access'),
};

const mutations = {
  setToken(state: AuthState, token: string) {
    state.token = token;
  },
  setUser(state: AuthState, user: any) {
    state.user = user;
  },
  setAuth(state: AuthState, status: boolean) {
    state.userLoggedIn = status;
  },
  clearAuthData(state: AuthState) {
    state.token = null;
    state.user = null;
    state.userLoggedIn = false;
  },
};

const actions = {
  async login({ commit }: any, { email, password }: { email: string, password: string }) {
    try {
      const response = await api.post<AuthResponse>('/auth/login', { email, password });
      const token = response.data.access_token;
      const user = jwtDecode(token);
      commit('setToken', token);
      commit('setUser', user);
      commit('setAuth', true);
      Cookies.set('access', token, { secure: true, sameSite: 'strict' });
    } catch (error) {
      console.error('Login failed:', error);
      throw error;
    }
  },
  logout({ commit }: any) {
    commit('clearAuthData');
    Cookies.remove('access');
  },
};

const getters = {
  isAuthenticated(state: AuthState): boolean {
    return !!state.token;
  },
  getToken(state: AuthState): string | null {
    return state.token;
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