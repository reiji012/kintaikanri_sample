<template>
  <div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/velocity/1.2.3/velocity.min.js"></script>

    <div id="staggered-list-demo">
      <input v-model="query">
      <transition-group
        name="staggered-fade"
        tag="ul"
        v-bind:css="false"
        v-on:before-enter="beforeEnter"
        v-on:enter="enter"
        v-on:leave="leave"
      >
        <li
          v-for="(item, index) in computedList"
          v-bind:key="item.msg"
          v-bind:data-index="index"
        >{{ item.msg }}</li>
      </transition-group>
    </div>
  </div>
</template>

<script>
  export default {
    data: {
      query: '',
      list: [
        { msg: 'Bruce Lee' },
        { msg: 'Jackie Chan' },
        { msg: 'Chuck Norris' },
        { msg: 'Jet Li' },
        { msg: 'Kung Fury' }
      ],
    },
    computed: {
      computedList: function () {
        var vm = this
        return this.list.filter(function (item) {
          return item.msg.toLowerCase().indexOf(vm.query.toLowerCase()) !== -1
        })
      }
    },

  }
</script>