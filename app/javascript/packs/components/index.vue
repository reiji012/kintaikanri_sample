<template>
  <div>    
    <div v-for="user in users" v-bind:key="'row_user_' + user.id" @click="showmodal(user)" id="show-modal" class="box userBox" style="clear:both;">
        <label v-bind:for="'user_' + user.id">{{ user.name }}</label>
    </div>
  <!-- use the modal component, pass in the prop -->
  <modal v-if="showModal" @close="showModal = false">
    <!--
      you can use custom content here to overwrite
      default content
    -->
    <h3 slot="header">{{ userName }}さんですか？</h3>

    <div slot="body">
      <form id="day">
        <select v-model="year" @change="get_days" id="year">
          <option v-for="n in 2" :key="n + 2017">
            {{ n + 2017 }}
          </option>
        </select>年
        <select v-model="month" @change="get_days" id="month">
          <option v-for="n in 12" :key="n">
            {{ n }}
          </option>
        </select>月
        <select v-model="date">
          <option v-for="n in days_max" :key="n">
            {{ n }}
          </option>
        </select>日
      </form>
      <p style="float: left; width: 50%;">帰社費用：　¥</p>
      <input type="number" v-model="amount" placeholder= "amount" style="float: right; width: 50%;" >
    </div>
    
    <div slot="footer">
      帰社登録します
        <div class="btn-group">
          <button type="button" @click="createRecord" class="btn btn-primary btn-sm button" style="float: left; margin-right: 30px;">登録</button>
          <button type="button" @click="showModal = false" v-on:click="set_day();" class="btn btn-default btn-sm button" style="float: right">キャンセル</button>
        </div>
        <p style="color: red;">{{errorMessage}}</p>
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
      userName: "",
      kana: "",
      userId: "",
      today: "",
      year: "",
      month: "",
      date: "",
      amount: 0,
      days_max: 0,
      errorMessage: "",
    };
  },
  mounted: function() {
    this.isLogin();
    this.fetchUsers();
    this.set_day();
  },
  created: function() {
    this.get_days();
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
      this.errorMessage = "";
      this.userName = user.name;
      this.amount = user.amount;
      this.userId = user.id;
      this.showModal = true;
    },
    isLogin: function() {
      if (true) {
        axios.get('/login');
      }
    },
    createRecord: function () {
      console.log(this.year);
          this.today = `${this.year}-${this.month}-${this.date}`;
      axios.post('/api/records', { record: { user_id: this.userId, return_date: this.today, amount: this.amount } }).then((response) => {
        if (response.data.message) {
          console.log(response.data.message);
          this.errorMessage = "その日はすでに登録されています。";
        } else {
          this.records.unshift(response.data.record);
         this.showModal = false;
        }
      })
      .catch(error => {
        console.log(error)
      });
      this.set_day();
      this.errorMessage = "";
    },
    get_days: function () {
      this.days_max = new Date(this.year, this.month, 0).getDate();
    },
    set_day: function() {
      let day = new Date();
      this.year = day.getFullYear();
      this.month = day.getMonth() + 1;
      this.date = day.getDate();
      this.today = `${this.year}-${this.month}-${this.date}`;
    },
  }
}
</script>
<style lang="sass">
    
</style>

