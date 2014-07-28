BowerInstallView = require './bower-install-view'

module.exports =
  bowerInstallView: null

  activate: (state) ->
    @bowerInstallView = new BowerInstallView(state.bowerInstallViewState)

  deactivate: ->
    @bowerInstallView.destroy()

  serialize: ->
    bowerInstallViewState: @bowerInstallView.serialize()
