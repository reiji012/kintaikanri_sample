<template>
  <div v-if="isLogin">
    <div class="switchButton" style="display: flex; float: left;">
      <router-link to="/">
        <div class="box" style="border-radius: 20px;">
            帰社登録
        </div>
      </router-link>
      <router-link to="recordCheck">
        <div class="box" style="border-radius: 20px;">
          記録確認
        </div>
      </router-link>
    </div>
    <slot name="settingButton">
      <div v-if="isAdmin">
        <router-link to="userRegistration">
          <div id="userPut" class="box" style="border-radius: 20px; float: right;">
            登録
          </div>
        </router-link><router-link to="userEdit">
          <div id="userPut" class="box" style="border-radius: 20px; float: right;">
            編集
          </div>
        </router-link>
      </div>
    </slot>
  </div>
</template>

<script>

import axios from 'axios';
import Cookies from 'js-cookie';

export default {

  data: function() {
    return {
      showModal: false,
      users: [],
      isAdmin: false,
      isLogin: false,
    };
  },
  mounted: function() {
    this.fetchUsers();
    this.loginCheck();
  },
  methods: {
    fetchUsers: function() {
      axios.get('/api/users').then((response) => {
        for(var i = 0; i < response.data.users.length; i++) {
          this.users.push(response.data.users[i]);
        }
      }, (error) => {
          console.log(error);
      });
    },
    loginCheck: function() {
      let loginUser = Cookies.get('loginUser')
      if (loginUser) {
        this.isLogin = true;
        if (loginUser == "admin") {
          this.isAdmin = true;
        }
      } 
    },
  }
}
</script>