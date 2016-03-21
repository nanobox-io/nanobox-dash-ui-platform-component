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
    statTypes = [
      {id:"cpu_used",  nickname: "CPU",  name:"CPU Used"}
      {id:"ram_used",  nickname: "RAM",  name:"RAM Used"}
      {id:"swap_used", nickname: "SWAP", name:"Swap Used"}
      {id:"disk_used", nickname: "DISK", name:"Disk Used"}
    ]
    @stats.initStats statTypes, {}
    @stats.build()

  updateLiveStats : (data) ->
    @stats.updateLiveStats data


  onAdminClick : (e) ->
    @onShowAdmin @id
