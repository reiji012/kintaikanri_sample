<template>
<div class = "row">
	 
  <div class = "col-md-6 col-md-offset-3">
		<p>{{ responseMessage }}</p>
		<p v-if="errors.length">
    <b>入力エラーがあります:</b>
    <ul>
      <li v-for="error in errors">{{ error }}</li>
    </ul>
  </p>
      <label >名前</label>
      <input v-model="name" class="form-control" type="text" v-on:input="update_furigana"/>

      <label >仮名（ひらがな）</label>
      <input v-model="furigana" class="form-control" type="text" />

      <label for="user_password">基本帰社費用</label>
      <input v-model="amount" class="form-control" type="number" />

      <input v-on:click="checkForm" :disabled="processing" type="submit" value="登録" class="btn btn-primary" />
  </div>
</div>
</template>

<script>
import historykana from 'historykana'
import axios from 'axios';

export default {
  data: function() {
		return {
			processing: false,
			name: "",
			furigana: "",
			amount: 0,
			history: [],
			status: "",
			user: [],
			errors: [],
			responseMessage: "",
		}
	},
	methods: {
		fetchUsers: function() {
			axios.get('/')
		},
		checkForm: function () {
      this.errors = [];

      if (!this.name) {
        this.errors.push("名前が入力されていません。");
      }
      if (!this.furigana) {
        this.errors.push('振り仮名が入力されていません。');
			}
			if (!(this.amount >= 0)) {
				this.errors.push('帰社費用を正しく入力してください。');
      }

      if (!this.errors.length) {
        this.createUser();
      }
    },
		createUser: function () {
			this.responseMessage = ""
			if (this.processing) return;
			this.processing = true;
      this.doSomething()
			axios.post('/api/users', { user: { name: this.name, kana: this.furigana, amount: this.amount } }).then((response) => {
				console.log("checklogs");
				console.log(response.data);
				this.name = "";
				this.furigana = "";
				this.amount = 0;
				this.responseMessage = "登録しました。"
				this.processing = false;
			}, (error) => {
				console.log(error);
				 this.records.user(response.data.record);
				this.responseMessage = "登録に失敗しました。入力内容を確認してください。"
			});
		},
		update_furigana (input) {
			this.history.push(input.target.value)
			this.furigana = historykana(this.history)
		},
		submit() {
      if (this.processing) return;
      this.processing = true;
      this.doSomething()
        .then(() => {
          this.processing = false;
        });
    },
    doSomething() {
      return new Promise((resolve) => {
        setTimeout(() => {
          console.log(`Submitted on ${new Date()}`);
          resolve();
        }, 1000);
      });
    },
	}
}
</script>

