<template>
  <v-app>
    <v-navigation-drawer app disable-resize-watcher v-model="drawer">
      <v-list dense>
        <v-list-item link to="/">
          <v-list-item-icon>
            <v-icon>mdi-home</v-icon>
          </v-list-item-icon>
          <v-list-item-content>主页w</v-list-item-content>
        </v-list-item>
        <v-list-item link to="/music">
          <v-list-item-icon>
            <v-icon>mdi-playlist-music</v-icon>
          </v-list-item-icon>
          <v-list-item-content>鹿乃的音乐w</v-list-item-content>
        </v-list-item>
        <v-list-item link to="/guitar">
          <v-list-item-icon>
            <v-icon>mdi-music</v-icon>
          </v-list-item-icon>
          <v-list-item-content>Guitar!</v-list-item-content>
        </v-list-item>
        <v-list-item link to="/bang">
          <v-list-item-icon>
            <v-icon>mdi-music</v-icon>
          </v-list-item-icon>
          <v-list-item-content>Bang!</v-list-item-content>
        </v-list-item>
        <v-list-item link to="/about">
          <v-list-item-icon>
            <v-icon>mdi-information</v-icon>
          </v-list-item-icon>
          <v-list-item-content>关于</v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>
        <v-subheader>友情链接w</v-subheader>
        <v-list-item link href="https://anillc.cn" target="_blank">
          <v-list-item-content>Anillc</v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar
      app
      :color="appTheme.color"
      :dark="appTheme.dark"
      :elevate-on-scroll="appTheme.elevate"
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title>kanocat~</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-menu open-on-hover offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn v-bind="attrs" v-on="on" icon>
            <v-icon>mdi-translate</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-list-item link v-for="(i, index) in languages" :key="index" @click="changeLanguage(i)">
            {{ i[0] }}
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>

    <v-main>
      <router-view></router-view>
    </v-main>

    <v-footer app :color="appTheme.color" :dark="appTheme.dark">&copy; 2020 Anillc</v-footer>
  </v-app>
</template>

<script lang="coffee">
export default
  name: 'App'
  data: ->
    drawer: false
    appTheme:
      color: 'white'
      dark: false
      elevate: true
    languages: [
      ['简体中文', 'zh']
      ['日本語', 'ja']
      ['CATALÀ', 'ca']
    ]
  mounted: ->
    this.checkUrl this.$route.name
  watch:
    '$route.name': (value) -> this.checkUrl value
  methods:
    checkUrl: (value) ->
      if value == 'Home'
        this.appTheme.color = 'white'
        this.appTheme.dark = false
        this.appTheme.elevate = true
      else
        this.appTheme.color = 'primary'
        this.appTheme.dark = true
        this.appTheme.elevate = false
    changeLanguage: (i) ->
      this.$i18n.locale = i[1]
</script>
