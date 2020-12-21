import best2bbb from './bestdori2bbb'

getMap = (level)->
  map = await (await fetch "/128.#{level}.json").json()
  URL.createObjectURL new Blob [best2bbb map]

getMusicSrc = ->
  "/bgm128.mp3"

module.exports = (level, speed) ->
  GameConfig:
    judgeOffset: 20
    visualOffset: 10
    speed: speed
    resolution: 1
    noteScale: 1
    barOpacity: 0.7
    backgroundDim: 0.7
    effectVolume: 1
    showSimLine: true
    laneEffect: true
    mirror: false
    beatNote: true
  GameLoadConfig:
    mapSrc: await getMap(level)
    musicSrc: await getMusicSrc()
    backgroundSrc: "/skin/bg.jpg"
    skin: "/skin"
    songName: "www"
