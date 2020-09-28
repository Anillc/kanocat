https = require 'https'
socketio = require 'socket.io'
Koa = require 'koa'
session = require 'koa-session'
bodyparser = require 'koa-bodyparser'
cors = require '@koa/cors'
fs = require 'fs'

grant = require 'grant'
  .koa()

config = require '../config/config.json'
grantConfig = require '../config/grant_config.json'

dao = require './dao'

app = new Koa()
app.keys = config.appKeys

options =
  key: fs.readFileSync '../config/privkey.pem'
  cert: fs.readFileSync '../config/fullchain.pem'

server = https.createServer options, app.callback()
io = socketio server

sessionMiddleware = session app

app.use cors
  'Access-Control-Allow-Origin': 'https://kano.cat'
  'Access-Control-Allow-Credentials': true
app.use sessionMiddleware
app.use bodyparser()
app.use grant grantConfig

io.use (socket, next) ->
  ctx = app.createContext socket.request, {} #这里不能为undefined，不然会报错
  await sessionMiddleware ctx, ->
    socket.session = ctx.session
    await next()

module.exports =
  app: app
  io: io
  server: server
  dao: dao