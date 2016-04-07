View = require 'view'
fullComponent = require 'jade/full-component'

module.exports = class FullView extends View

  constructor: ($el, @componentKind, @onCloseClick, @componentId) ->
    super $el, @componentKind, @adminCb
    @build $el

  build : ($el) ->
    details = nanobox.PlatformComponent.getComponentDetails @componentKind
    @$node = $ fullComponent( {kind: @componentKind, name:details.friendlyName, description:details.description} )
    $el.append @$node
    shadowIconsInstance.svgReplaceWithString pxSvgIconString, @$node
    $(".back-btn", @$node).on "click", (e)=> @onCloseClick(e)

    data =
      isPlatformComponent : true
      id                  : @componentId
      name                : details.friendlyName
      serviceType         : @componentKind
    @box = new nanobox.ClobberBox()
    @box.build $('.bg-div', @$node), nanobox.ClobberBox.PLATFORM_COMPONENT, data

  onAdminClick : (e) ->
    @adminCb @componentKind

  destroy : (cb) ->
    @box?.destroy()
    $(".back-btn", @$node).off()
    super cb
