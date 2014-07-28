{View} = require 'atom'

module.exports =
class BowerInstallView extends View
  @content: ->
    @div class: 'bower-install overlay from-top', =>
      @div "The BowerInstall package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "bower-install:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "BowerInstallView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
