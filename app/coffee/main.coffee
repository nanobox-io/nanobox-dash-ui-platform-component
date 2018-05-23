MiniView = require 'mini-view'
FullView = require 'full-view'

class PlatformComponent

  ###
  @$el             : Jquery element to attach to
  @componentKind   : The type of platform component (must be one of the class kinds listed below)
  @serviceId       : Id of the component
  ###
  constructor : (@$el, data) ->
    @componentKind = data.componentKind
    @serviceId     = data.serviceId
    @isSplitable   = data.isSplitable
    @mode          = data.mode
    @showAdminCb   = data.showAdminCb
    @resetViewCb   = data.resetViewCb
    @componentIds  = data.componentIds
    @componentId   = @serviceId

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
    @component = new MiniView @$el, @componentKind, @serviceId, @componentIds, @triggerFullView

  buildFullView : () =>
    @component = new FullView @$el, @componentKind, @triggerClose, @serviceId, @mode
    @box       = @component.box

  hide          :    -> @component.destroy()

  # ------------------------------------ Events

  triggerFullView : () => @showAdminCb(@serviceId)
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
        return
          friendlyName : "Load Balancer"
          description  : "All web requests are routed through the load balancer. If your app has a horizontally scaled web service, the load balancer round-robins requests to your various web instances. If you need redundancy, switch to Scalable"

      when PlatformComponent.logger
        return
          friendlyName : "Logger"
          description  : "The logger captures and stores logs from your app's components."

      when PlatformComponent.healthMonitor
        return
          friendlyName : "Monitor"
          description  : "The monitor component tracks and stores resource usage (RAM, CPU, Disk, etc.) of components and nodes."

      when PlatformComponent.router
        return
          friendlyName : "Message Bus"
          description  : "The message bus pushes data such as resource usage metrics and logs to the Nanobox dashboard/API for live updates."

      when PlatformComponent.storage
        return
          friendlyName : "Warehouse"
          description  : "The warehouse is a storage component that houses files and data required for Nanobox apps. This includes code builds and data backups."



window.nanobox ||= {}
nanobox.PlatformComponent = PlatformComponent
