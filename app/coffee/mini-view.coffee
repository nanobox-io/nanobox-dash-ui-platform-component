View = require 'view'
miniComponent = require 'jade/mini-component'

module.exports = class MiniView extends View

  constructor: ($el, @kind, @id, @componentIds, @onShowAdmin) ->
    super $el, @kind, @onShowAdmin
    @build $el

  build : ($el) ->
    details = nanobox.PlatformComponent.getComponentDetails @kind

    @$node = $ miniComponent( {kind: @kind, name:details.friendlyName} )
    $el.append @$node
    castShadows @$node
    @addStats $ ".stats-box", @$node
    $(".ui-box", @$node).on "click", (e)=> @onAdminClick(e)

  addStats : ($el) ->
    data =
      view : "micro"
      metrics     : ['cpu', 'ram']
      entity      : "component"
      entityId    : @componentIds.join("&")

    @stats = new nanobox.HourlyStats $el, data
    @stats.build()

  updateLiveStats : (data) ->
    @stats.updateLiveStats data


  onAdminClick : (e) ->
    @onShowAdmin @kind

  destroy : (cb) ->
    $(".ui-box", @$node).off()
    super cb
