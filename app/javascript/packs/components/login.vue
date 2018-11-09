<template>
  <div id="signin">
    <h2>Sign up</h2>
    <p>{{ errorMessage }}</p>
    <input type="text" placeholder="Login_id" v-model="loginId">
    <input type="password" placeholder="Password" v-model="password">
    <router-link to="/">
      <button @click="login">Register</button>
    </router-link>
  </div>
</template>

<script>
import axios from 'axios';
import Cookies from 'js-cookie';

export default {
  name: 'Login',
  data () {
    return {
      loginUser: '',
      loginId: '',
      password: '',
      admin: false,
      errorMessage: "",
    }
  },
  methods: {
    login: function() {
      console.log({loginUser: { login_id: this.loginId, password: this.password }})
      axios.post('/login', { loginUser: { login_id: this.loginId, password: this.password } }).then((response) => {
        if (response.data.loginUser.admin) {
          this.loginUser = "admin"
        } else {
          this.loginUser = "guest"
        }
        Cookies.set('loginUser', this.loginUser);
        window.location.href = '/';
      })
      .catch(error => {
        console.log(error)
        this.errorMessage = "idまたはパスワードが違います"
      });
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>