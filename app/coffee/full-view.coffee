View = require 'view'
fullComponent = require 'jade/full-component'

module.exports = class FullView extends View

  constructor: ($el, @id, @onCloseClick) ->
    super $el, @id, @adminCb
    @build $el

  build : ($el) ->
    @$node = $ fullComponent( {kind: @id, name:nanobox.PlatformComponent.getHumanName(@id)} )
    @$node.css opacity: 0
    $el.append @$node
    shadowIconsInstance.svgReplaceWithString pxSvgIconString, @$node

    $(".back-btn", @$node).on "click", (e)=> @onCloseClick(e)
    @fadeIn()

  onAdminClick : (e) ->
    @adminCb @id
