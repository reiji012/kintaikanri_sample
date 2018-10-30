<template>
  <div>    
    {{ userCount }}
    <table class="table">
    <thead>
        <tr>
            <th>登録ID</th>
            <th>名前</th>
            <th>帰社費用</th>
            <th>帰社日数</th>
        </tr>
    </thead>
    <tbody v-for="user in users" v-bind:key="user.id" v-on="countDate(user)">
        <tr>
            <th>{{ user.id }}</th>
            <td>{{ user.name }}</td>
            <td>
              <input v-model="user.amount" type="number" />
            </td>
            <td>{{ partRecords.length }}</td>
        </tr>
    </tbody>
</table>
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
      isLogin: false,
      amount: 0,
      amounts: [],
      editMode: false,
      countDates: 0,
      count: 0,
      userCount: 0,
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
        this.users = [];
        for(var i = 0; i < response.data.users.length; i++) {
          this.users.push(response.data.users[i]);
          this.userCount += 1
        }
      }, (error) => {
          console.log(error);
        });
    },
    fetchRecords: function() {
      axios.get('/api/records').then((response) => {
        this.records = [];
        for(var i = 0; i < response.data.records.length; i++) {
          this.records.push(response.data.records[i]);
          console.log(this.records)
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
      console.log(this.amount_sum)
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
      console.log("setRecord around")
      this.countDates = 0;
      this.amount = 0;
      let month = this.monthCheck();
      let regDay = new RegExp(this.year + "-" + month);
      for (let i = 0; this.records.length > i; i++) {
        console.log(i)
        let record = this.records[i];
        console.log(record);
        if (record.user_id == this.userId && regDay.test(record.return_date)) {
          this.countDates += 1;
          this.amount += record.amount
        }
      }
    },
    shift:function(val){
        if('back'===val){
          this.month = (this.month===1)?12:this.month-1;
          this.year = (this.month===12)?this.year-1:this.year;
        }else{
          this.month = (this.month===12)?1:this.month+1;
          this.year = (this.month===1)?this.year+1:this.year;
        }
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
    recordReset: function() {
        this.fetchRecords();
        this.setRecord();
        this.showModal = false
        this.showModal = true
    },
    countDate: function(user) {
      this.userId = user.id
      console.log("countDate around")
    }
  },
  computed: {
    amountSum: function() {
      this.amount_sum = 0;
      for (let i = 0; i < this.partRecords.length; i++) {
        let record = this.partRecords[i]
        this.amount_sum += Number(record.amount);
      }
      return this.amount_sum
    },
    
  }
}
</script>