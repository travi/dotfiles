View = require '../View'
MarkerView = require './MarkerView'
{ config } = atom

module.exports =
class HighlightView extends View

  @className: ''

  @content: ->
    @div class: @className


  configProperty: ''

  constructor: ->
    super
    config.observe @configProperty, =>
      @setEnabled config.get @configProperty

  update: (rowsList) ->
    @empty()
    return unless rowsList?.length
    for rows in rowsList
      @append new MarkerView rows

  setEnabled: (isEnabled) ->
    if isEnabled
      @removeClass 'is-disabled'
    else
      @addClass 'is-disabled'
