import { createApp } from 'vue';
import './style.css';
import App from './App.vue';
import store from './store';
import router from './routes/index.js';
import Toast from 'vue-toastification';
import 'vue-toastification/dist/index.css';

const app = createApp(App);

store.dispatch('initLogin').then(() => {
  app.use(router).use(store).use(Toast).mount('#app');
});