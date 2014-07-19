View = require '../View'

module.exports =
class RegionView extends View

  @MIDDLE_ROW: parseInt '00', 2
  @FIRST_ROW: parseInt '01', 2
  @LAST_ROW: parseInt '10', 2
  @SINGLE_ROW: parseInt '11', 2

  @content: ->
    @div class: 'region'


  constructor: ({ tl, br }, isFirstRow, isLastRow) ->
    super()

    where = RegionView.MIDDLE_ROW
    if isFirstRow
      where |= RegionView.FIRST_ROW
    if isLastRow
      where |= RegionView.LAST_ROW
    switch where
      when RegionView.FIRST_ROW
        @addClass 'first'
      when RegionView.MIDDLE_ROW
        @addClass 'middle'
      when RegionView.LAST_ROW
        @addClass 'last'

    @css
      left  : tl.left
      top   : tl.top
      width : br.left - tl.left
      height: br.top - tl.top
