_ = require 'lodash'
util = require 'util'
lrc = require 'lrc.js'
fs = require 'fs'

readFile = util.promisify (_.curry fs.readFile) _, 'utf-8'

lrcs = fs.readdirSync './kanolrc'

random = (min, max) -> parseInt Math.random() * (max - min + 1) + min, 10

module.exports = ranlrc = ->
  lrcFile = lrcs[random 0, lrcs.length - 1]
  file = await readFile "./kanolrc/#{lrcFile}"
  lyric = lrc.parse file
    .toJSON()
  text = lyric.lines[random 0, lyric.lines.length - 1].text
  name = lrcFile
  { text, name }