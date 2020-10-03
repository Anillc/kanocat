<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center" class="fill-height">
      <v-col>
        <v-card>
          <v-card-title>
              聊天室，未完成
          </v-card-title>
          <v-card-text>
              <div ref="term"></div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="coffee">
{ Terminal } = require 'xterm'
{ FitAddon } = require 'xterm-addon-fit'
io = require 'socket.io-client'

module.exports =
  name: 'Chat'
  data: ->
    term: null
    socket: null
    input: ''
  mounted: ->
    this.term = new Terminal()
    fit = new FitAddon()
    this.term.loadAddon fit
    this.term.open this.$refs.term
    fit.fit()
    this.term.onKey this.onInput
    this.socket = io 'https://api.kano.cat:2226'
    this.socket.on 'msg', (msg) =>
      this.term.write msg.text
      this.term.write '\x1b\x45> '
    this.socket.on 'notice', (notice) =>
      this.term.write notice
  methods:
    onInput: (i) ->
      if i.domEvent.keyCode != 13
        this.input += i.key
        this.term.write i.key
        return
      if this.input == '/login'
        window.location = 'https://api.kano.cat:2226/connect/github'
        return
      this.socket.emit 'msg', this.input
      this.input = ''
      this.term.write '\x1b\x45'
</script>

<style lang="less" scoped>
</style>