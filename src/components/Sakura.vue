<template>
  <div ref="awa" class="awa">
    <img ref="hana" class="hana" :src="require('@/assets/sakura.png')"/>
    <p ref="title" class="title"></p>
  </div>
</template>

<script lang="coffee">
THREE = require 'three'
{ CSS3DRenderer, CSS3DObject } = require 'three/examples/jsm/renderers/CSS3DRenderer'

module.exports =
  name: 'Sakura'
  props:
    title: String
  data: ->
    w: null
    h: null
    scene: new THREE.Scene()
    cam: null
    renderer: new CSS3DRenderer()
    hana: null
    hanas: []
    v: new THREE.Vector3()
  mounted: ->
    @hana = @$refs.hana
    @w = @$refs.awa.offsetWidth
    @h = @$refs.awa.offsetHeight
    @cam = new THREE.PerspectiveCamera 100, @w / @h, 1, 5000
    @renderer.setSize @w, @h
    @cam.position.set 0, 0, 500
    @cam.lookAt new THREE.Vector3 0, 0, 0
    @$refs.awa.appendChild @renderer.domElement
    window.addEventListener 'resize', @resize, false
    @init()
    @createHana() for i in [1..20]
    @rtitle();
    @ani();
  beforeDestroy: -> window.removeEventListener 'resize', @resize
  methods:
    ani: ->
      requestAnimationFrame @ani
      j = 0;
      while j < @hanas.length
        i = @hanas[j]
        if i.obj.position.z >= 600
          @scene.remove i.obj
          @hanas = @hanas.filter (n) -> n != i
          @createHana()
          j--
        else
          i.obj.position.set(
            i.obj.position.x + i.rx
            i.obj.position.y + i.ry
            i.obj.position.z + i.rz
          )
        j++
      @renderer.render @scene, @cam
    createHana: ->
      cloneHana = @hana.cloneNode()
      cloneHana.style.display = 'block'
      obj = new CSS3DObject cloneHana
      obj.position.copy @v
      @hanas.push
        obj: obj
        rx: Math.round(Math.random() * (@w / 4)) / 10
        ry: -10
        rz: `(function rand() {
          let r = Math.round(Math.random() * 20);
          return r == 0 ? rand() : r;
        })()`
      @scene.add obj
    resize: ->
      @w = @$refs.awa.offsetWidth
      @h = @$refs.awa.offsetHeight
      @cam.aspect = @w / @h
      @cam.updateProjectionMatrix()
      @renderer.setSize @w, @h
      @init()
    init: ->
      v = new THREE.Vector3()
      v.x = -1.1
      v.y = 1.1
      v = new THREE.Vector3 v.x, v.y, 0.5
        .unproject @cam
      ray = new THREE.Ray(
        @cam.position
        v.sub(@cam.position).normalize()
      )
      ray.at 600, @v
    rtitle: ->
      title = @$refs.title.cloneNode()
      title.style.display = 'block'
      title.innerText = @title
      t1 = new CSS3DObject title
      t1.position.set 0, 20, 350
      @scene.add t1
</script>

<style lang="less" scoped>
.title {
  color: rgb(20, 20, 20);
  font-size: 25px;
  display: none;
}
.awa {
  background-color: #fff;
}
.hana {
  width: 15px;
  height: 15px;
  filter: blur(1px);
  display: none;
}
</style>