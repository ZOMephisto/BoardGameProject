<template>
  <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
    <GameCard
      v-for="game in games"
      :key="game.ID_Game"
      :game="game"
    />
  </div>
</template>

<script>
import GameCard from './GameCard.vue';

export default {
  name: 'GameList',
  components: {
    GameCard
  },
  props: {
    games: {
      type: Array,
      required: true
    }
  }
}
</script>