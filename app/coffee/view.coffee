module.exports = class View

  constructor: ($el, @id, @adminCb) ->

  destroy : (cb) ->
    $(".ui-box", @$node).off()
    @$node.remove()
    cb?()
