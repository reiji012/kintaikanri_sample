<template>
  <div>
    <div id="record">
      <div v-for="user in users" v-bind:key="'row_user_' + user.id" @click="showmodal(user)" id="show-modal" class="box userBox">
        <label v-bind:for="'user_' +user.id">{{ user.name }}</label>
      </div>
    </div>

  <!-- use the modal component, pass in the prop -->
  <modal v-if="showModal" @close="showModal = false" v-show="!loading">

    <div slot="header">
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
      帰社記録_帰社費用合計<span id="amount_sum" style="color: #008000">¥{{ amountSum }}</span>
    </div>
    <div slot="body">
      <div v-if="partRecords.length > 0" style="margin-bottom: 1em; width: 50%;" > 
        <div v-if="!editMode" @click="editMode = true" v-on:click="recordBackup = partRecords" class="box button" >編集</div>
      </div>
        <div v-if="editMode" v-on:click="editMode = false" @click="recordReset()" class="box button" style="margin-bottom: 1em; width: 50%;">キャンセル</div>
      <ul class="list-group">
        <li v-for="(record, index) in partRecords" v-bind:key="'row_task_' + record.id" v-bind:id="'record_' + record.id" v-bind:class="{ editMode: editMode }" class="list-group-item">
          <label v-bind:for="'record_' + record.id">{{ record.return_date }}__</label>
          <div v-if="editMode" @click="setDeleteRecords(record, index)" class="box deleteButton button" style="float: right; margin-bottom: 0em;">
            削除
          </div>
          <label v-if="!editMode" v-bind:for="'record_' + record.id" v-bind:class="{differenceAmount: userAmount != record.amount}">¥{{ record.amount }}</label>
          <input v-else type="number" v-model="record.amount">

          
        </li>
      </ul>
    </div>
    <div slot="footer">
      <div v-if="!editMode" @click="showModal = false" v-on:click="setRecord()" class="box button">確認</div>
      <div v-else v-on:click="updateRecords" @click="editMode = false" class="box updateButton button">更新</div>
    </div>
    
  </modal>

  <loading-modal v-show="loading">
    <div slot="body">
      {{ loadingMessage }}
    </div>
  </loading-modal>
</div>
  
</template>

<script>
import Switch from "./button.vue";
import Modal from "./modal.vue";
import axios from "axios";
import LoadingModal from "./loadingModal.vue"

export default {
  components: {
    switchButton: Switch,
    modal: Modal,
    loadingModal: LoadingModal,
  },
  data: function() {
    return {
      showModal: false,
      users: [],
      records: [],
      deleteRecords: [],
      partRecords: [],
      recordBackup: [],
      userName: "test",
      userId: "",
      recordId: "",
      amount_sum: 0,
      year: "",
      month: "",
      date: "",
      day: "",
      isLogin: false,
      amount: 0,
      amounts: [],
      editMode: false,
      loading: false,
      loadingMessage: "",
      userAmount: 0,
    };
  },
  watch: {
    showModal: function() {
      if (this.showModal === true) {
        this.editMode = false;
      }
    }
  },
  mounted: function() {
    this.records = [];
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
          }
          this.loading = false;
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
          }
          this.loading = false
        },
        error => {
          console.log(error);
        }
      );
    },
    showmodal: function(user) {
      this.userName = user.name;
      this.userId = user.id;
      this.userAmount = user.amount
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
    setRecord: function() {
      this.fetchRecords();
      this.partRecords = [];
      this.amounts = [];
      let month = this.monthCheck();
      let regDay = new RegExp(this.year + "-" + month);
      for (let i = 0; i < this.records.length; i++) {
        let record = this.records[i];
        if (record.user_id == this.userId && regDay.test(record.return_date)) {
          this.partRecords.push(record);
          let record_amount = { record_id: record.id, amount: record.amount };
          this.amounts;
          this.amounts.push(record_amount);
        }
      }
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
    pushAmount: function() {
      this.partRecords[0].amount += 1;
    },
    chengeAmount: function() {
      console.log({ records: this.partRecords });
    },
    updateRecords: function() {
      this.loadingMessage = "変更内容を登録中....."
      this.loading = true;
      axios.patch("/api/records/1", this.partRecords).then(
        response => {
          this.loading = false;
        },
        error => {
          console.log(error);
        }
      );
      if (this.deleteRecords.length > 0) {
        this.deleteRecord();
      } 
      console.log(this.partRecords);
    },
    recordReset: function() {
      this.fetchRecords();
      this.setRecord();
      this.showModal = false;
      this.showModal = true;
      this.deleteRecords = [];
    },
    setDeleteRecords: function(record, index) {
      this.deleteRecords.push(record)
      this.partRecords.splice(index, 1);
    },
    deleteRecord: function() {
      console.log(this.deleteRecords)
      this.loading = true;
      for (let i = 0; i < this.deleteRecords.length; i++) {
        const record = this.deleteRecords[i];
        axios.delete(`/api/records/${record.id}`, record).then(
          response => { 
            this.loading = false;
          },
          error => {
            console.log(error);
          }
        );
      }
      this.deleteRecords = [];
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
    },
    differenceAmmount: function(record) {
      return {
        "differenceAmmount": this.userAmount != record.amount
      }
    }
  }
};
</script>