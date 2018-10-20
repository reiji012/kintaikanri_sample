<template>
  <div>
    <div id="record">
    <div v-for="user in users" v-bind:key="'row_user_' + user.id" @click="showmodal(user)" id="show-modal" class="box userBox">
      <label v-bind:for="'user_' +user.id">{{ user.name }}</label>
    </div>
    </div>
  <!-- use the modal component, pass in the prop -->
  <modal v-if="showModal" @close="showModal = false">
    <!--
      you can use custom content here to overwrite
      default content
    -->
    <div slot="header">帰社記録_帰社費用合計<span id="amount_sum" style="color: #008000">¥{{ amount_sum }}</span>
    </div>
    <div slot="body">
    <ul class="list-group">
        <li v-for="record in records" v-if="record.user_id == userId" v-bind:key="'row_task_' + record.id" class="list-group-item">
        <label v-bind:for="'record_' + record.id">{{ record.return_date }}</label>
        <label v-bind:for="'record_' + record.id">___¥{{ record.amount }}</label>
        </li>
    </ul>
    </div>
    <div slot="footer">
      <div @click="showModal = false" class="box">確認</div>
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
      records: [],
      userName: "test",
      userId: "",
      amount_sum: 0,
    };
  },
  mounted: function() {
    this.fetchUsers();
    this.fetchRecords();
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
    fetchRecords: function() {
      axios.get('/api/records').then((response) => {
        for(var i = 0; i < response.data.records.length; i++) {
          this.records.push(response.data.records[i]);
        }
      }, (error) => {
          console.log(error);
        });
    },
    showmodal: function(user) {
      this.userName = user.name;
      this.userId = user.id;
      this.showModal = true;
      this.amount_sum = 0;
      for (let i = 0; i < this.records.length; i++) {
        let record = this.records[i];
        if (record.user_id == this.userId) {
          this.amount_sum += record.amount;
        }
        
      }
    },
  }
}
</script>
<style lang="sass">
    
</style>