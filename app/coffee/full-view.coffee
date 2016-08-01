View = require 'view'
fullComponent = require 'jade/full-component'

module.exports = class FullView extends View

  constructor: ($el, @componentKind, @onCloseClick, @componentId, mode) ->
    super $el, @componentKind, @adminCb
    @build $el, mode

  build : ($el, mode) ->
    details = nanobox.PlatformComponent.getComponentDetails @componentKind
    @$node = $ fullComponent( {kind: @componentKind, name:details.friendlyName, description:details.description} )
    $el.append @$node
    castShadows @$node
    $(".back-btn", @$node).on "click", (e)=> @onCloseClick(e)
    $(".option", @$node).on   "click", (e)=> @onOptionClick(e)
    data =
      isPlatformComponent : true
      id                  : @componentId
      name                : details.friendlyName
      serviceType         : @componentKind
    # @box = new nanobox.ClobberBox()
    # @box.build $('.bg-div', @$node), nanobox.ClobberBox.PLATFORM_COMPONENT, data
    @setSplitability mode != "simple"

  onAdminClick : (e) ->
    @adminCb @componentKind

  onOptionClick : (e) ->
    if $(e.currentTarget).hasClass 'simple'
      @setSplitability false
    else
      @setSplitability true

  setSplitability : (isSplitable) ->
    return if @isSplitable == isSplitable
    @isSplitable = isSplitable

    # @box.box.setSplitability isSplitable
    $(".option", @$node).removeClass 'active'

    if isSplitable
      $(".option.scalable").addClass('active').find('input').prop('checked', true)
    else
      $(".option.simple").addClass('active').find('input').prop('checked', true)

  destroy : (cb) ->
    @box?.destroy()
    $(".back-btn", @$node).off()
    super cb
