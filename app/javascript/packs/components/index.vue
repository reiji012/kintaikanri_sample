<template>
  <div>
    <switchButton></switchButton>
    <div v-for="user in users" v-bind:key="'row_user_' + user.id" @click="showmodal(user.name)" id="show-modal" class="box userBox">
        <label v-bind:for="'user_' + user.id">{{ user.name }}</label>
    </div>
  <!-- use the modal component, pass in the prop -->
  <modal v-if="showModal" @close="showModal = false">
    <!--
      you can use custom content here to overwrite
      default content
    -->
    <h3 slot="header">{{ userName }}さんですか？</h3>
  </modal>
</div>
  
</template>

<script>
import Switch from "./button.vue";
import Modal from "./modal.vue";
import axios from 'axios';

export default {
  components: {
    switchButton: Switch,
    modal: Modal
  },
  data: function() {
    return {
      showModal: false,
      users: [],
      userName: "test",
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
    },
    showmodal: function(name) {
      this.userName = name
      this.showModal = true;
    },
  }
}
</script>
<style lang="sass">
    
</style>

