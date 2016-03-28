View = require 'view'
miniComponent = require 'jade/mini-component'

module.exports = class MiniView extends View

  constructor: ($el, @id, @onShowAdmin) ->
    super $el, @id, @onShowAdmin
    @build $el

  build : ($el) ->
    @$node = $ miniComponent( {kind: @id, name:nanobox.PlatformComponent.getHumanName(@id)} )
    @$node.css opacity: 0
    $el.append @$node
    shadowIconsInstance.svgReplaceWithString pxSvgIconString, @$node

    @addStats $ ".stats-box", @$node

    $(".ui-box", @$node).on "click", (e)=> @onAdminClick(e)
    @fadeIn()

  addStats : ($el) ->
    @stats = new nanobox.HourlyStats $el, nanobox.HourlyStats.micro
    @stats.build()

  updateLiveStats : (data) ->
    @stats.updateLiveStats data


  onAdminClick : (e) ->
    @onShowAdmin @id
