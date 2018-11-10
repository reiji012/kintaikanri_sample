<template>
  <div class="header">
    <nav>
    <header class="navbar navbar-fixed-top navbar-inverse box">
      <div class="container">
        <a href="/" class="brand-logo left">Sample Application</a>
          <label @click="logout" v-if="isLogin" for="logout" style="float: right; margin: 0 auto;">Logout</label>
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
  updated: function() {
    this.loginCheck();
  },
  methods: {
    logout: function() {
      Cookies.remove('loginUser');
      document.location = "/login"
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