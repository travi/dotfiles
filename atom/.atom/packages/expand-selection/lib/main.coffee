ExpandSelection = require './expand-selection'

module.exports =
  activate: ->
    @expandSelection = new ExpandSelection()

  deactivate: ->
    @expandSelection?.destroy()
    @expandSelection = null
