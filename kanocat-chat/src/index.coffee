{ app, io, server, dao } = require './init.coffee'

dao = dao()

routes = (require './routes') dao
chat = require './chat'

app.use routes
chat io, dao

app.use (ctx, next) ->
  sess = ctx.cookies.get 'koa.sess'
  ctx.cookies.set 'koa.sess', sess,
    maxAge: 86400000
    domain: '.kano.cat'
  await next()

server.listen 2226