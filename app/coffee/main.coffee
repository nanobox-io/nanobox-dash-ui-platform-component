MiniView = require 'mini-view'
FullView = require 'full-view'

class PlatformComponent

  ###
  @$el             : Jquery element to attach to
  @componentKind   : The type of platform component (must be one of the class kinds listed below)
  @componentId     : Id of the component
  ###
  constructor : (@$el, data) ->
    @componentKind = data.componentKind
    @componentId   = data.componentId
    @isSplitable   = data.isSplitable
    @mode          = data.mode
    @showAdminCb   = data.showAdminCb
    @resetViewCb   = data.resetViewCb

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


  buildMiniView : () =>
    @component = new MiniView @$el, @componentKind, @componentId, @triggerFullView

  buildFullView : () =>
    @component = new FullView @$el, @componentKind, @triggerClose, @componentId, @mode
    @box       = @component.box

  hide          :    -> @component.destroy()

  # ------------------------------------ Events

  triggerFullView : () => @showAdminCb(@componentId)
  triggerClose    : () => @resetViewCb()

  # ------------------------------------ Class vars and methods

  @loadBalancer   : "mesh"
  @logger         : "logger"
  @healthMonitor  : "monitor"
  @router         : "pusher"
  @storage        : "warehouse"

  @getHumanName   : (id)->
    switch id
      when PlatformComponent.loadBalancer  then return "Load Balancer"
      when PlatformComponent.logger        then return "Glob storage"
      when PlatformComponent.healthMonitor then return "Health Monitor"
      when PlatformComponent.router        then return "Router"
      when PlatformComponent.storage       then return "Storage"

  @getComponentDetails : (id) ->

    switch id
      when PlatformComponent.loadBalancer
        return {
          friendlyName : "Load Balancer"
          description  : "All web requests are routed through the load balancer. If your app has a horizontally scaled web service, the load balancer round-robins requests to your various web instances. If you need redundancy, switch to Scalable"
        }
      when PlatformComponent.logger
        return {
          friendlyName : "Logger"
          description  : "Logger placeholder, All web requests are routed through the load balancer. If your app has a horizontally scaled web service, the load balancer round-robins requests to your various web instances. If you need redundancy, switch to Scalable"
        }
      when PlatformComponent.healthMonitor
        return {
          friendlyName : "Health Monitor"
          description  : "Dummy text, all web requests are routed through the load balancer. If your app has a horizontally scaled web service, the load balancer round-robins requests to your various web instances. If you need redundancy, switch to Scalable"
        }
      when PlatformComponent.router
        return {
          friendlyName : "Router"
          description  : "Lorem ipsum all web requests are routed through the load balancer. If your app has a horizontally scaled web service, the load balancer round-robins requests to your various web instances. If you need redundancy, switch to Scalable"
        }
      when PlatformComponent.storage
        return {
          friendlyName : "Glob Storage"
          description  : "Placeholder text all web requests are routed through the load balancer. If your app has a horizontally scaled web service, the load balancer round-robins requests to your various web instances. If you need redundancy, switch to Scalable"
        }


window.nanobox ||= {}
nanobox.PlatformComponent = PlatformComponent
