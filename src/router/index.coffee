import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'

Vue.use VueRouter

routes = [
  {
    path: '/'
    name: 'Home'
    component: Home
  }, {
    path: '/music'
    component: -> import('../views/Music.vue')
  }, {
    path: '/bang'
    component: -> import('../views/Bang.vue')
  }, {
    path: '/about'
    component: -> import('../views/About.vue')
  }, {
    path: '/guitar'
    component: -> import('../views/Guitar.vue')
  }
]

export default new VueRouter {
  mode: 'history'
  routes
}
