<template>
<div class = "row">
  <div class = "col-md-6 col-md-offset-3">
      <label >名前</label>
      <input v-model="name" class="form-control" type="text" v-on:input="update_furigana"/>

      <label >仮名（ひらがな）</label>
      <input v-model="furigana" class="form-control" type="text" />

      <label for="user_password">基本帰社費用</label>
      <input v-model="amount" class="form-control" type="number" />

      <input v-on:click="createUser" type="submit" value="登録" class="btn btn-primary" />
  </div>
</div>
</template>

<script>
import historykana from 'historykana'
import axios from 'axios';

export default {
    data: function() {
        return {
			name: "",
			furigana: "",
			amount: 0,
			history: []
		}
	},
	methods: {
		createUser: function () {
      		axios.post('/api/users', { user: { name: this.name, kana: this.furigana, amount: this.amount } }).then((response) => {
         		this.users.unshift(response.data.user);
       		}, (error) => {
         		console.log(error);
       		});
		},
		update_furigana (input) {
    this.history.push(input.target.value)
    this.furigana = historykana(this.history)
    }
	}
}
</script>

