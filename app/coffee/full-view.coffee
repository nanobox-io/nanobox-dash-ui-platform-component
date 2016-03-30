View = require 'view'
fullComponent = require 'jade/full-component'

module.exports = class FullView extends View

  constructor: ($el, @id, @onCloseClick) ->
    super $el, @id, @adminCb
    @build $el

  build : ($el) ->
    @$node = $ fullComponent( {kind: @id, name:nanobox.PlatformComponent.getHumanName(@id)} )
    $el.append @$node
    shadowIconsInstance.svgReplaceWithString pxSvgIconString, @$node
    $(".back-btn", @$node).on "click", (e)=> @onCloseClick(e)

  onAdminClick : (e) ->
    @adminCb @id

  destroy : (cb) ->
    $(".back-btn", @$node).off()
    super cb
