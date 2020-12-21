import Vue from 'vue'
import VueI18n from 'vue-i18n'
import zh from '../locales/zh.json'
import ja from '../locales/ja.json'
import ca from '../locales/ca.json'

Vue.use VueI18n

export default new VueI18n
  locale: 'zh'
  fallbackLocale: 'zh'
  messages: {
    zh
    ja
    ca
  }
