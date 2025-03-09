import { createStore } from 'vuex';
import auth from './modules/auth';
import series from './modules/series';

const store = createStore({
  modules: {
    auth,
    series,
  },
});

export default store;