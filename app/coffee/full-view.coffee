View = require 'view'
fullComponent = require 'jade/full-component'

module.exports = class FullView extends View

  constructor: ($el, @id, @onCloseClick) ->
    super $el, @id, @adminCb
    @build $el

  build : ($el) ->
    details = nanobox.PlatformComponent.getComponentDetails @id
    @$node = $ fullComponent( {kind: @id, name:details.friendlyName, description:details.description} )
    $el.append @$node
    shadowIconsInstance.svgReplaceWithString pxSvgIconString, @$node
    $(".back-btn", @$node).on "click", (e)=> @onCloseClick(e)

    platformComponent = new nanobox.ClobberBox()
    platformComponent.build $('.component-div', @$node), nanobox.ClobberBox.PLATFORM_COMPONENT, clobberBoxDataShim.getPlatformComponent("lb", "Load Balancer", "load-balancer")

  onAdminClick : (e) ->
    @adminCb @id

  destroy : (cb) ->
    $(".back-btn", @$node).off()
    super cb
