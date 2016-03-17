module.exports = class View

  constructor: ($el, @id, @adminCb) ->

  destroy : (cb) ->
    @fadeOut ()=>
      $(".ui-box", @$node).off()
      @$node.remove()
      cb?()

  fadeIn  : (cb) -> @$node.velocity {opacity:1}, {duration:300, complete: cb}
  fadeOut : (cb) -> @$node.velocity {opacity:0}, {duration:130, complete: cb}
