<template>
  <v-container class="fill-height">
    <v-row align="baseline" justify="center" class="fill-height">
      <v-col>
        <v-card class="mb-8">
          <v-card-title>关于本页</v-card-title>
          <v-card-text>
            本页面由<a href="https://blog.lotywe.cc">lotywe</a>提供w
            <br/>使用OneManager提供OneDrive的直链下载
          </v-card-text>
        </v-card>
        <v-card>
          <v-card-text>
            <iframe src="https://music.ans.ee" frameborder="0" class="ifr"></iframe>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="coffee">
export default
  name: 'Music'
  mounted: ->
</script>

<style lang="less" scoped>
.ifr {
  width: 100%;
  height: 500px;
}
</style>
