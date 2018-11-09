<template>
  <div class="header">
    <nav>
    <header class="navbar navbar-fixed-top navbar-inverse box">
      <div class="container">
        <a href="/" class="brand-logo left">Sample Application</a>
        <router-link to="login" v-if="isLogin" @click="logout" for="logout" style="float: right; margin: 0 auto;">
          Logout
        </router-link>
      </div>
    </header>
    </nav>
  </div>
</template>

<script>
import Cookies from 'js-cookie';

export default {
  data: function() {
    return {
      isLogin: false,
    }
  },
  mounted: function() {
    this.loginCheck();
  },
  methods: {
    logout: function() {
      Cookies.remove('loginUser');
    },
    loginCheck: function() {
      let loginUser = Cookies.get('loginUser')
      if (loginUser) {
        this.isLogin = true;
      } 
    },
  }
}
</script>


<style lang="sass">
</style>