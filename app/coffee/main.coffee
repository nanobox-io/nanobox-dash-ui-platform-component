MiniView = require 'mini-view'
FullView = require 'full-view'

class PlatformComponent

  constructor : (@$el, @id) ->
    Eventify.extend @
    @events     = {}
    shadowIcons = new pxicons.ShadowIcons()


  # ------------------------------------ API

  setState : (state) ->
    switch state
      when "hidden" then @hide()
      when "mini"   then @destroyCurrentComponent @buildMiniView
      when "full"   then @destroyCurrentComponent @buildFullView

  destroy : () ->
    @off()
    @component.destroy()
    @component = null

  # ------------------------------------ Methods

  destroyCurrentComponent : (newComponentCb) ->
    if @component?
      @component.destroy newComponentCb
    else
      newComponentCb()


  buildMiniView : () => @component = new MiniView @$el, @id, @triggerFullView
  buildFullView : () =>
    @component = new FullView @$el, @id, @triggerClose
  hide          :    -> @component.destroy()

  # ------------------------------------ Events

  triggerFullView : () => @fire "show-admin", @id
  triggerClose    : () => @fire "close-detail-view"

  # ------------------------------------ Class vars and methods

  @loadBalancer   : "load-balancer"
  @logger         : "logger"
  @healthMonitor  : "health-monitor"
  @router         : "router"
  @storage        : "glob-storage"

  @getHumanName   : (id)->
    switch id
      when PlatformComponent.loadBalancer  then return "Load Balancer"
      when PlatformComponent.logger        then return "Glob storage"
      when PlatformComponent.healthMonitor then return "Health Monitor"
      when PlatformComponent.router        then return "Router"
      when PlatformComponent.storage       then return "Storage"


window.nanobox ||= {}
nanobox.PlatformComponent = PlatformComponent
