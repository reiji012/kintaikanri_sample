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

    <!-- 前月移動ボタン -->
    <div slot="header">
      <div style="display:flex">
        <div class="headerItem shiftButton">
          <div class="dateItem border table button" v-on:click="shift('back')">
            <p>←</p>
          </div>
        </div>
        <!-- 年月表示 -->
        <div v-cloak class="headerItem monthYear">
          <div class="dateItem border table">
            <span class="middle">{{year}}年{{this.month}}月</span>
          </div>
        </div>
        <!-- 次月移動 -->
        <div class="headerItem shiftButton">
          <div class="dateItem border table button" v-on:click="shift('next')">
            <p>→</p>
          </div>
        </div>
      </div>
      帰社記録_帰社費用合計<span id="amount_sum" style="color: #008000">¥{{ amount_sum }}</span>
    </div>
    <div slot="body">
    <ul class="list-group">
        <li v-for="record in partRecords" v-bind:key="'row_task_' + record.id" class="list-group-item">
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
      partRecords: [],
      userName: "test",
      userId: "",
      amount_sum: 0,
      year: "",
      month: "",
      date: "",
      day: "",
    };
  },
  mounted: function() {
    this.fetchUsers();
    this.fetchRecords();
    let day = new Date();
    this.year = day.getFullYear();
    this.month = day.getMonth() + 1;
    this.date = day.getDate();
    this.day = `${this.year}-${this.month}`;
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
      this.setRecord();
      this.showModal = true;
    },
    recordCheck: function(record) {
      let regDay = new RegExp(this.day);
      if (record.user_id != userId) {
        return false;
      } else {
        if (!(regDay.test(record.return_date))) {
          return false;
        } else {
          return true;
        }
      }
    },
    setRecord: function() {
      this.amount_sum = 0;
      this.partRecords = [];
      let month = this.monthCheck();
      let regDay = new RegExp(this.year + "-" + month);
      for (let i = 0; i < this.records.length; i++) {
        let record = this.records[i];
        if (record.user_id == this.userId && regDay.test(record.return_date)) {
          this.amount_sum += record.amount;
          this.partRecords.push(record)
        }
      }
      console.log(this.partRecords);
    },
    shift:function(val){
        if('back'===val){
          this.month = (this.month===1)?12:this.month-1;
          this.year = (this.month===12)?this.year-1:this.year;
        }else{
          this.month = (this.month===12)?1:this.month+1;
          this.year = (this.month===1)?this.year+1:this.year;
        }
        // this.month = ( '00' + this.month ).slice( -2 );
        this.day =`${this.year}-${this.month}`
        console.log(this.day)
        this.setRecord();
      },
      monthCheck: function() {
        let month = this.month + "";
        if (month.length == 1) {
          return "0" + month;
        } else {
          return this.month
        }
      },
  }
}
</script>
<style lang="sass">
    
</style>