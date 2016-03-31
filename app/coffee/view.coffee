module.exports = class View

  constructor: ($el, @componentKind, @adminCb) ->

  destroy : (cb) ->
    $(".ui-box", @$node).off()
    @$node.remove()
    cb?()
