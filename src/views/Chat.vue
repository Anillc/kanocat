<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center" class="fill-height">
      <v-col>
        <v-card>
          <v-card-title>
              聊天室，未完成
          </v-card-title>
          <v-card-text>
              <div class="term" ref="term"></div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="coffee">
{ Terminal } = require 'xterm'
io = require 'socket.io-client'

module.exports =
  name: 'Chat'
  data: ->
    term: null
    socket: null
    input: ''
  mounted: ->
    this.term = new Terminal()
    this.term.open this.$refs.term
    this.term.onKey this.onInput
    this.socket = io 'https://api.kano.cat:2226'
    this.socket.on 'msg', (msg) =>
      this.term.write msg.text
    this.socket.on 'notice', (notice) =>
      this.term.write notice
  methods:
    onInput: (i) ->
      if i.keyCode == 13
        this.socket.write this.input
        this.input = ''
        return
      this.input += i.key
      this.term.write i.key
</script>

<style lang="less" scoped>
.term {
    overflow: hidden;
}
</style>