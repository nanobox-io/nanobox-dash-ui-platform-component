View = require 'view'
miniComponent = require 'jade/mini-component'

module.exports = class MiniView extends View

  constructor: ($el, @id, @onShowAdmin) ->
    super $el, @id, @onShowAdmin
    @build $el

  build : ($el) ->
    details = nanobox.PlatformComponent.getComponentDetails @id

    @$node = $ miniComponent( {kind: @id, name:details.friendlyName} )
    $el.append @$node
    shadowIconsInstance.svgReplaceWithString pxSvgIconString, @$node
    @addStats $ ".stats-box", @$node
    $(".ui-box", @$node).on "click", (e)=> @onAdminClick(e)

  addStats : ($el) ->
    @stats = new nanobox.HourlyStats $el, nanobox.HourlyStats.micro
    @stats.build()

  updateLiveStats : (data) ->
    @stats.updateLiveStats data


  onAdminClick : (e) ->
    @onShowAdmin @id

  destroy : (cb) ->
    $(".ui-box", @$node).off()
    super cb
