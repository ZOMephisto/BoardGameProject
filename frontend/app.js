const { createApp } = Vue;

createApp({
  data() {
    return {
      count: 0
    }
  },
  async mounted() {
    const response = await fetch('/api/ping');
    const data = await response.json();
    this.count = data.count;
  }
}).mount('#app');