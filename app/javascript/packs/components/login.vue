<template>
  <div id="signin">
    <h2>Sign up</h2>
    <input type="text" placeholder="Username" v-model="username">
    <input type="password" placeholder="Password" v-model="password">
    <button>Register</button>
  </div>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      username: '',
      password: '',
    }
  },
  methods: {}
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>