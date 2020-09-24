import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '@/views/Home.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  }, {
    path: '/music',
    component: () => import('@/views/Music.vue')
  }, {
    path: '/bang',
    component: () => import('@/views/Bang.vue')
  }, {
    path: '/about',
    component: () => import('@/views/About.vue')
  }, {
    path: '/guitar',
    component: () => import('@/views/Guitar.vue')
  } 
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
