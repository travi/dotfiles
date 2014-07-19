View = require '../View'

module.exports =
class StatusView extends View

  @content: ->
    @div class: 'refactor-status inline-block', =>
      @span class: 'lint-name'
      @span class: 'lint-summary'
