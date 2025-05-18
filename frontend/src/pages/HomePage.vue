<template>
  <div class="container py-4">
    <h1 class="text-center mb-4">Bibliothèque de Jeux Partagés</h1>

    <div v-if="loading" class="text-center">
      <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Chargement...</span>
      </div>
    </div>

    <div v-else-if="error" class="alert alert-danger">
      {{ error }}
    </div>

    <GameList v-else :games="games" />
  </div>
</template>

<script>
import GameList from '../components/GameList.vue';

export default {
  name: 'HomePage',
  components: {
    GameList
  },
  data() {
    return {
      games: [],
      loading: true,
      error: null
    }
  },
  async mounted() {
    try {
      const response = await fetch('/api/game');
      if (!response.ok) throw new Error('Erreur lors du chargement des jeux');
      this.games = await response.json();
    } catch (err) {
      this.error = err.message;
    } finally {
      this.loading = false;
    }
  }
}
</script>