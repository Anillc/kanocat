module.exports = (io, {User, Msg}) ->
  io.on 'connection', (socket) ->
    userId = socket.session.userId
    if !userId
      socket.emit 'notice', '未登录，输入/login登录w'
      socket.disconnect()
      return
    user = await User.findById userId

    msgs = await Msg.find().limit(10).exec()
    socket.emit 'msg', eMsg for eMsg in msgs

    io.emit 'notice', "#{user.name}进入了房间w"
    socket.on 'disconnect', -> io.emit 'notice', "#{user.name}退出了房间umm"
    socket.on 'msg', (message) ->
      msg = new Msg
        user: userId
        text: "#{user.name}: #{message}"
      msg.save()
      io.emit 'msg', msg