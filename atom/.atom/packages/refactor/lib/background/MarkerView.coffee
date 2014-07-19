View = require '../View'
RegionView = require './RegionView'

module.exports =
class MarkerView extends View

  @content: ->
    @div class: 'marker'


  constructor: (rows) ->
    super()
    min = 0
    max = rows.length - 1
    for row, i in rows
      @append new RegionView row, i is min, i is max
