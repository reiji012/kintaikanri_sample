<template>
    <div>
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
        <router-link to="userRegistration">
        <div id="userPut" class="box" style="border-radius: 20px; float: right;">
            ユーザー設定
        </div>
        </router-link>
        </slot>
    </div>
</template>

<script>

import axios from 'axios';

export default {

  data: function() {
    return {
      showModal: false,
      users: [],
      isAdmin: false,
    };
  },
  mounted: function() {
    this.fetchUsers();

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
    }
  }
}
</script>