import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Index from '../components/index.vue'
import RecordCheck from '../components/recordCheck.vue'
import UserRegistration from '../components/userRegistration.vue'
import Login from '../components/login.vue'
import userEdit from '../components/userEdit.vue'
import Cookies from 'js-cookie';
Vue.use(VueRouter)

// Require dependencies
// Tell Vue to use the plugin

var router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Index },
    { path: '/recordCheck', component: RecordCheck },
    { path: '/userRegistration', component: UserRegistration },
    { path: '/login', component: Login },
    { path: '/userEdit', component: userEdit },
  ]
});

export default router

router.beforeEach((to, from, next) => {
 
  if (to.path !== "/login") {
    if (Cookies.get('loginUser')) {
      next()
      } else {
        next({ path: '/login' });
      }
  } else {
    next();
  }
})

