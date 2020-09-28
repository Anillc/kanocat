Router = require 'koa-router'

module.exports = ({ User }) ->
  router = new Router()

  router.get '/', (ctx) ->
    ctx.response.redirect 'https://kano.cat'

  router.get '/logedin', (ctx) ->
    profile = ctx.session.grant?.response.profile
    if !profile or profile.error
      ctx.session.grant = undefined
      ctx.body = "登录失败，请返回重试"
      return
    user = await (User.findOne
      'ghId': profile.id).exec()
    if !user
      user = new User
        ghId: profile.id
        name: profile.login
        profile: JSON.stringify profile
        lastLogin: new Date()
      await user.save()
    ctx.session.userId = user['_id']
    ctx.response.redirect 'https://kano.cat/chat'

  router.routes()