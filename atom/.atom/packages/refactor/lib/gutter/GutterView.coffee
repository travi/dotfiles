View = require '../View'
{ $ } = require 'atom'

module.exports =
class GutterView extends View

  @content: ->
    @div()

  constructor: (@gutter) ->
    super()

  empty: ->
    @gutter.removeClassFromAllLines 'refactor-error'
    @gutter
    .find '.line-number .icon-right'
    .attr 'title', ''

  update: (errors) ->
    @empty()
    return unless errors?
    for { range, message } in errors
      $ @gutter.getLineNumberElement range.start.row
      .addClass 'refactor-error'
      .attr 'title', message
