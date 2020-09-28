<template>
  <v-container ref="gameContainer" class="fill-height">
    <v-row align="baseline" justify="center" class="fill-height">
      <v-col>
        <v-card class="mb-6">
          <v-card-title>心拍数#0822</v-card-title>
          <v-card-text>
            这里以后会放更多的吉他谱，高三了没空折腾，就先这样叭w
            <br />感谢
            <a href="https://space.bilibili.com/19902329?from=search&seid=8750448084577824">赛兰sir</a>
            制作的谱子
            <br />可能会加载一会儿，请稍等
          </v-card-text>
        </v-card>
        <v-card>
          <v-card-text>
            <v-btn class="secondary" @click="play">播放</v-btn>
            <br /><br />点击播放按钮后可能将无法移动页面，如果需要退出请刷新页面
            <div ref="main"></div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="coffee">
module.exports =
  name: 'Guitar'
  data: ->
    api: null
  mounted: ->
    this.api = new window.alphaTab.AlphaTabApi this.$refs.main,
      file: '/xps.gp'
      player:
        enablePlayer: true
        soundFont: '/js/font/sonivox.sf2'
    window.api = this.api
  beforeDestroy: ->
    # this.api?.stop()
    this.api?.destroy()
  methods:
    play: ->
      this.api.play()
</script>

<style lang="less" scoped>
</style>