atom = require 'atom'

module.exports =
class View extends atom.View

  constructor: ->
    super

  destruct: ->
    @remove()
