import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Index from '../components/index.vue'
import RecordCheck from '../components/recordCheck.vue'
import UserRegistration from '../components/userRegistration.vue'
import Login from '../components/login.vue'

Vue.use(VueRouter)

var router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Index, meta: { requiresAuth: true } },
    { path: '/recordCheck', component: RecordCheck },
    { path: '/registration', component: UserRegistration },
    { path: '/login', component: Login },
  ]
});

export default router

router.beforeEach((to, from, next) => {
  next({ name: Login});
})

