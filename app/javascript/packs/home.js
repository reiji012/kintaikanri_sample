import Vue from 'vue/dist/vue.esm.js'
import Header from './components/header.vue'
import Router from './router/router'
import SwitchButton from './components/button.vue'

var app = new Vue ({
    router: Router,
    el: '#app',
    components: {
        'navbar': Header,
        'switchButton': SwitchButton,
    }
});