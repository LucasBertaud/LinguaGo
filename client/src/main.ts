import { createApp } from 'vue';
import './style.css';
import App from './App.vue';
import store from './store';
import router from './routes/index.js';
import Toast from 'vue-toastification';
import 'vue-toastification/dist/index.css';
import VueApexCharts from 'vue3-apexcharts';

const app = createApp(App);

store.dispatch('initLogin').then(() => {
  app.use(router).use(store).use(Toast).use(VueApexCharts).mount('#app');
});