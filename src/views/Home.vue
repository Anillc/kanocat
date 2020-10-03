<template>
  <v-container fluid class="fill-height pa-0 ma-0 ctr">
    <!-- <v-img position="center" src="../assets/bg.jpg"/> -->
    <!-- <v-row justify="center" align="center"> -->
    <v-row justify="center" align="center">
      <v-col>
        <!-- <p class="text-center">{{ $t('home') }}</p> -->
        <p class="home">
          {{ $t("home") }}
          <br />
          <small>
            {{ lrc }}
            <br />
            <small>{{ name }}</small>
          </small>
        </p>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="coffee">
superagent = require 'superagent'

module.exports =
  name: 'Home'
  data: ->
    lrc: ''
    name: ''
  mounted: ->
    ranlrc = await superagent.get 'https://api.kano.cat:2226/lrc'
    this.lrc = ranlrc.body.text
    this.name = ranlrc.body.name
</script>

<style lang="less" scoped>
.ctr {
  background-image: url(../assets/bg.jpg);
  background-position: top;
  background-size: 100%;
}

@media (max-width: 567px) {
  .ctr {
    background-position: auto 5%;
    background-position: bottom;
    background-size: 250%;
  }
}

.home {
  padding-left: 10%;
  padding-bottom: 20%;
  font-size: 1.5em;
  color: #444444;
}
</style>