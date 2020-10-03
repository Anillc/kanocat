mongoose = require 'mongoose'
config = require '../config/config.json'

Schema = mongoose.Schema

module.exports = ->
  mongoose.connect config.mongodb,
    useNewUrlParser: true
    useUnifiedTopology: true
    useFindAndModify: false
    useCreateIndex: true
  User = mongoose.model 'User', new Schema
    ghId: Number
    name: String
    profile: String
    ban:
      type: Boolean
      default: false
    lastLogin: Date
  Msg = mongoose.model 'Msg', new Schema
    user: Schema.ObjectId
    text: String
    time:
      type: Date
      default: Date.now
  { User, Msg }