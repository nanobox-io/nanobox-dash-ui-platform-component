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
    castShadows @$node
    @addStats $ ".stats-box", @$node
    $(".ui-box", @$node).on "click", (e)=> @onAdminClick(e)

  addStats : ($el) ->
    data =
      view : "micro"
      metrics     : ['cpu', 'ram']
      entity      : "component"
      entityId    : @id

    @stats = new nanobox.HourlyStats $el, {view:"micro"}
    @stats.build()

  updateLiveStats : (data) ->
    @stats.updateLiveStats data


  onAdminClick : (e) ->
    @onShowAdmin @id

  destroy : (cb) ->
    $(".ui-box", @$node).off()
    super cb
