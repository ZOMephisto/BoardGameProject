import { createApp } from 'vue';
import HomePage from './src/pages/HomePage.vue';

// Création de l'application Vue
const app = createApp({
  template: '<HomePage />'
});

// Enregistrement des composants globaux (si nécessaire)
app.component('HomePage', HomePage);

// Montage de l'application
app.mount('#app');