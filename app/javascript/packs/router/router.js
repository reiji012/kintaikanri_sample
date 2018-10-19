import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Index from '../components/index.vue'
import RecordCheck from '../components/recordCheck.vue'
import UserRegistration from '../components/userRegistration.vue'


Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Index },
    { path: '/recordCheck', component: RecordCheck },
    { path: '/userRegistration', component: UserRegistration },
  ],
})