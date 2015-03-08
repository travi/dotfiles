ColorGutterView = null

module.exports =

  configDefaults:
    ignoreCommentedLines: false

  activate: ->
    atom.workspaceView.command 'color-gutter:toggle', => @toggle()
    @colorGutterViews = []
    @enable()

  deactivate: ->
    @disable()

  enable: ->
    @enabled = true
    ColorGutterView ?= require './color-gutter-view'

    atom.workspaceView.eachEditorView (editorView) =>
      if editorView.attached and editorView.getPane()?
        @colorGutterViews.push(new ColorGutterView(editorView))

  disable: ->
    while view = @colorGutterViews.shift()
      view.destroy()

    @enabled = false

  toggle: ->
    if @enabled
      @disable()
    else
      @enable()
