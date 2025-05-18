<template>
  <div class="col">
    <div class="card game-card h-100">
      <img :src="game.Image || 'https://via.placeholder.com/300x200?text=Jeu+de+société'"
           class="card-img-top"
           :alt="game.Name">
      <div class="card-body">
        <h5 class="card-title">{{ game.Name }}</h5>
        <p class="card-text">{{ truncatedDescription }}</p>
      </div>
      <ul class="list-group list-group-flush">
        <li class="list-group-item">
          <i class="fas fa-users me-2"></i>
          {{ game.Minimum_Number_of_Players }} - {{ game.Maximum_Number_of_Players }} joueurs
        </li>
        <li class="list-group-item">
          <i class="fas fa-birthday-cake me-2"></i>
          À partir de {{ game.Minimum_Age }} ans
        </li>
        <li class="list-group-item">
          <i class="fas fa-euro-sign me-2"></i>
          {{ game.Price_per_Day }} € / jour
        </li>
      </ul>
      <div class="card-footer bg-transparent">
        <button class="btn btn-primary w-100">Réserver</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'GameCard',
  props: {
    game: {
      type: Object,
      required: true
    }
  },
  computed: {
    truncatedDescription() {
      return this.game.Description.length > 100
        ? this.game.Description.substring(0, 100) + '...'
        : this.game.Description;
    }
  }
}
</script>

<style scoped>
.game-card {
  transition: transform 0.2s;
}
.game-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0,0,0,0.1);
}
.card-img-top {
  height: 200px;
  object-fit: cover;
}
</style>