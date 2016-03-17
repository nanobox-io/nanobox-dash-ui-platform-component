View = require 'view'

module.exports = class MiniView extends View

  constructor: ($el, @id, @onShowAdmin) ->
    super $el, @id, @onShowAdmin
    @build $el

  build : ($el) ->
    @$node = $ jadeTemplate['mini-component']( {kind: @id, name:nanobox.PlatformComponent.getHumanName(@id)} )
    @$node.css opacity: 0
    $el.append @$node
    shadowIconsInstance.svgReplaceWithString pxSvgIconString, @$node

    $(".ui-box", @$node).on "click", (e)=> @onAdminClick(e)
    @fadeIn()

  onAdminClick : (e) ->
    @onShowAdmin @id
