<template>
  <div>
    <switchButton></switchButton>
    <div v-for="user in users" v-bind:key="'row_user_' + user.id" @click="showmodal(user)" id="show-modal" class="box userBox">
        <label v-bind:for="'user_' + user.id">{{ user.name }}</label>
    </div>
  <!-- use the modal component, pass in the prop -->
  <modal v-if="showModal" @close="showModal = false">
    <!--
      you can use custom content here to overwrite
      default content
    -->
    <h3 slot="header">{{ userName }}さんですか？</h3>
    <div slot="footer">
      帰社登録します
			<div>
        <button type="button" @click="showModal = false" v-on:click="createRecord" class="btn btn-primary btn-lg btn-block" style="float: left">はい</button>
        <button type="button" @click="showModal = false" class="btn btn-default btn-lg btn-block" style="float: tight">いいえ</button>
			</div>
    </div>
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
      userName: "",
      userId: "",
      today: "",
    };
  },
  mounted: function() {
    this.fetchUsers();
    let day = new Date();
    let year = day.getFullYear();
    let month = day.getMonth() + 1;
    let date = day.getDate();
    this.today = `${year}-${month}-${date}`;
    console.log(this.today)
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
    showmodal: function(user) {
      this.userName = user.name
      this.userId = user.id
      this.showModal = true;
    },
    createRecord: function () {
      axios.post('/api/records', { record: { user_id: this.userId, return_date: this.today } }).then((response) => {
         this.records.unshift(response.data.record);
         this.newTask = '';
       }, (error) => {
         console.log(error);
       });
     }
  }
}
</script>
<style lang="sass">
    
</style>

