ColorGutterView = null

module.exports =
  config:
    ignoreCommentedLines:
      type: 'boolean',
      default: false

  activate: ->
    atom.commands.add 'atom-workspace',
      'color-gutter:toggle': => @toggle()

    @colorGutterViews = []
    @enable()

  deactivate: ->
    @disable()

  enable: ->
    @enabled = true
    ColorGutterView ?= require './color-gutter-view'

    atom.workspace.observeTextEditors (editor) =>
      @colorGutterViews.push(new ColorGutterView(editor))

  disable: ->
    while colorGutterView = @colorGutterViews.shift()
      colorGutterView.destroy()

    @enabled = false

  toggle: ->
    if @enabled
      @disable()
    else
      @enable()
