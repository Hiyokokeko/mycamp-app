<template>
  <div class="container">
    <div>
      <Logo />
      <h1 class="title">mycamp-app</h1>
      <h2 class="subtitle">
        {{ subTitle }}
      </h2>
      <button @click="getSomething">タスク取得</button>
      <!-- 取得したtasksをリスト形式で表示する -->
      <ul v-for="task in tasks" :key="task.id">
        <li style="text-align: left">{{ task.title }}</li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      subTitle: "mycamp is good service!!",
      tasks: [],
    };
  },
  methods: {
    async getSomething() {
      // タスク一覧を取得するためのAPIを叩く
      const response = await this.$axios.$get(
        "http://localhost:3000/api/v1/tasks"
      );
      this.tasks = JSON.parse(response.tasks);
    },
  },
};
</script>

<style>
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.title {
  font-family: "Quicksand", "Source Sans Pro", -apple-system, BlinkMacSystemFont,
    "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  display: block;
  font-weight: 300;
  font-size: 100px;
  color: #35495e;
  letter-spacing: 1px;
}

.subtitle {
  font-weight: 300;
  font-size: 42px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.links {
  padding-top: 15px;
}
</style>
