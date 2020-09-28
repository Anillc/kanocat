<template>
  <v-container ref="gameContainer" class="fill-height">
    <v-row align="baseline" justify="center" class="fill-height">
      <v-col>
        <v-card class="mb-6">
          <v-card-title>bang!</v-card-title>
          <v-card-subtitle>来打六兆年吧XD</v-card-subtitle>
          <v-card-text>
            <v-form v-model="vaild">
              <v-select :items="levels" label="难度" :rules="[v => !!v || '请选择难度']" v-model="level" />
              <v-text-field label="速度" :rules="speedRules" v-model="speed" />
              <v-btn @click="start" color="secondary" :disabled="started || !vaild">开始游戏</v-btn>
            </v-form>
            <v-snackbar v-model="started">加载中w</v-snackbar>
          </v-card-text>
        </v-card>
        <v-card class="mb-6">
          <v-card-title>提示</v-card-title>
          <v-card-text>
            建议使用Chrome、Firefox等浏览器游戏
            <br/>由于使用的轮子有少量(大量？)bug，出现问题刷新一下就好啦w
            <br/>轮子链接<a href="https://github.com/K024/bangbangboom-game">bangbangboom-game</a>
          </v-card-text>
        </v-card>
        <v-card>
          <v-card-title>排行榜</v-card-title>
          <v-card-subtitle>
            这里记录在这儿打过的人的分数w
            <br />请自觉打游戏哦，不要用特殊手段来提升排名ww
          </v-card-subtitle>
          <v-card-text>这个功能还没实现XD</v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="coffee">
bang = require 'bangbangboom-game'
bangUtils = require '../utils/bang.coffee'

module.exports =
  name: 'Bang'
  data: ->
    started: false
    levels: ['easy', 'normal', 'hard', 'expert', 'special']
    vaild: true
    speedRules: [
      (value) -> !!value || '不能为空'
      (value) -> !isNaN value || '请输入有效数字'
      (value) -> value?.trim?() != '' || '请输入有效数字'
      (value) -> (parseFloat value) > 0 && (parseFloat value) <= 11 || '请输入有效数字'
    ]
    level: 'expert'
    speed: 9.5
  mounted: -> 
  methods:
    start: ->
      this.started = true
      document.getElementsByTagName('body')[0].requestFullscreen()

      gameContainer = this.$refs.gameContainer
      canvas = document.createElement 'canvas'
      canvas.classList.add 'bang-game'
      canvas.width = window.innerWidth
      canvas.height = window.innerHeight
      gameContainer.appendChild canvas
      configs = await bangUtils(this.level, this.speed)
      game = new bang.Game(canvas, configs.GameConfig, configs.GameLoadConfig)
      game.start()

      game.ondestroyed = =>
        this.started = false
        gameContainer.removeChild canvas
        if document.fullscreen
          document.exitFullscreen()
</script>

<style lang="less">
.bang-game {
  position: fixed;
  left: 0;
  top: 0;
  z-index: 99999;
}
</style>