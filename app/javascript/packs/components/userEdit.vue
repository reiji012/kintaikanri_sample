<template>
  <div class="">    
    <table class="table">
    <thead>
      <div class="showDate">
        <!-- 年月表示 -->
        <div v-cloak class="headerItem monthYear">
          <div class="dateItem border table ">
            <span class="middle">{{year}}年{{this.month}}月</span>
          </div>
        </div>
        <!-- 前月移動ボタン -->
        <div class="headerItem shiftButton"  style="margin-right: 1em; margin-left: 1em;">
          <div class="dateItem border table button" v-on:click="shift('back')">
            <p>＜</p>
          </div>
        </div>
        <!-- 次月移動 -->
        <div class="headerItem shiftButton">
          <div class="dateItem border table button" v-on:click="shift('next')">
            <p>＞</p>
          </div>
        </div>
        
      </div>
        <tr>
            <th>登録ID</th>
            <th>名前</th>
            <th>帰社費用</th>
            <th>月帰社日数</th>
            <th>月合計帰社費用</th>
        </tr>
    </thead>
    <tbody v-for="user in users" v-bind:key="user.id" v-on="countDate(user)" @click="showmodal(user)" class="userList">
        <tr>
            <th>{{ user.id }}</th>
            <td>{{ user.name }}</td>
            <td>{{ user.amount }}</td>
            <td>{{ countDate(user, "date") }}日</td>
            <td>¥{{ countDate(user, "amount") }}</td>
        </tr>
    </tbody>
</table>

<modal v-if="showModal" @close="showModal = false" style="width: 400px;">
    <!--
      you can use custom content here to overwrite
      default content
    -->
    <h3 slot="header">{{ userName }}</h3>

    <div slot="body">
      <div class = "row">
	 
  <div>
    <div @click="deleteUser()" class="box deleteButton button" style="float: right;">
      削除
    </div>
    <label >名前</label>
    <input v-model="user.name" class="form-control" type="text" v-on:input="update_furigana"/>

    <label >仮名（ひらがな）</label>
    <input v-model="user.kana" class="form-control" type="text" />
    <label for="user_password">基本帰社費用</label>
    <input v-model="user.amount" class="form-control" />

    <input v-on:click="updateUser" :disabled="processing" type="submit" value="登録" class="btn btn-primary" />
  </div>
</div>
    </div>
    
    <div slot="footer">
    </div>
  </modal>
  </div>
  
</template>

<script>
import Switch from "./button.vue";
import Modal from "./modal.vue";
import axios from "axios";

export default {
  components: {
    switchButton: Switch,
    modal: Modal
  },
  data: function() {
    return {
      showModal: false,
      user: [],
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
      userCount: 0
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
      axios.get("/api/users").then(
        response => {
          this.users = [];
          for (var i = 0; i < response.data.users.length; i++) {
            this.users.push(response.data.users[i]);
            this.userCount += 1;
          }
        },
        error => {
          console.log(error);
        }
      );
    },
    fetchRecords: function() {
      axios.get("/api/records").then(
        response => {
          this.records = [];
          for (var i = 0; i < response.data.records.length; i++) {
            this.records.push(response.data.records[i]);
            console.log(this.records);
          }
        },
        error => {
          console.log(error);
        }
      );
    },
    showmodal: function(user) {
      this.userName = user.name;
      this.userId = user.id;
      this.user = user;
      this.setRecord();
      this.showModal = true;
      console.log(this.amount_sum);
    },
    recordCheck: function(record) {
      let regDay = new RegExp(this.day);
      if (record.user_id != userId) {
        return false;
      } else {
        if (!regDay.test(record.return_date)) {
          return false;
        } else {
          return true;
        }
      }
    },
    setRecord: function(userId) {
      console.log("setRecord around");
      let countDate = 0;
      let countAmount = 0;
      let partRecord = [];
      this.amount = 0;
      let month = this.monthCheck();
      let regDay = new RegExp(this.year + "-" + month);
      for (let i = 0; this.records.length > i; i++) {
        console.log(i);
        let record = this.records[i];
        console.log(record);
        if (record.user_id == userId && regDay.test(record.return_date)) {
          countDate += 1;
          countAmount += record.amount;
        }
      }
      partRecord = [countDate, countAmount];
      return partRecord;
    },
    shift: function(val) {
      if ("back" === val) {
        this.month = this.month === 1 ? 12 : this.month - 1;
        this.year = this.month === 12 ? this.year - 1 : this.year;
      } else {
        this.month = this.month === 12 ? 1 : this.month + 1;
        this.year = this.month === 1 ? this.year + 1 : this.year;
      }
      this.day = `${this.year}-${this.month}`;
      console.log(this.day);
      this.setRecord();
    },
    monthCheck: function() {
      let month = this.month + "";
      if (month.length == 1) {
        return "0" + month;
      } else {
        return this.month;
      }
    },
    recordReset: function() {
      this.fetchRecords();
      this.setRecord();
      this.showModal = false;
      this.showModal = true;
    },
    countDate: function(user, value) {
      let record = this.setRecord(user.id);
      if (value === "date") {
        return record[0];
      } else {
        return record[1];
      }
      console.log("countDate around");
    },
    countAmount: function(user) {
      let record = this.setRecord;
    },
    updateUser: function(user) {
      axios.patch(`/api/users/${this.userId}`, this.user).then(
        response => {
          this.fetchUsers();
          this.fetchRecords();
          this.setRecord();
          this.showModal = false;
        },
        error => {
          console.log(error);
        }
      );
    },
    deleteUser: function(user) {
      axios.delete(`/api/users/${this.userId}`, this.user).then(
        response => {
          this.fetchUsers();
          this.fetchRecords();
          this.setRecord();
          this.showModal = false;
        },
        error => {
          console.log(error);
        }
      );
    }
  },
  computed: {
    amountSum: function() {
      this.amount_sum = 0;
      for (let i = 0; i < this.partRecords.length; i++) {
        let record = this.partRecords[i];
        this.amount_sum += Number(record.amount);
      }
      return this.amount_sum;
    }
  }
};
</script>