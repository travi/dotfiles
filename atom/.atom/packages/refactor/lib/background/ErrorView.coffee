HighlightView = require './HighlightView'

module.exports =
class ErrorView extends HighlightView

  @className: 'refactor-error'
  configProperty: 'refactor.highlightError'
