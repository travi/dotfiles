{CompositeDisposable} = require 'atom'
RegExps = require './color-gutter-regexps'

module.exports =
class ColorGutterView
  constructor: (@editor) ->
    @subscriptions = new CompositeDisposable()
    @bufferSubscriptions = new CompositeDisposable()
    @decorations = {}
    @markers = []

    @editorView = atom.views.getView @editor

    @config =
      ignoreCommentedLines: atom.config.get 'color-gutter.ignoreCommentedLines'

    @subscriptions.add atom.config.onDidChange 'color-gutter.ignoreCommentedLines', @watchConfigChanges

    @subscriptions.add @editor.onDidChangePath @subscribeToBuffer
    @subscriptions.add @editor.onDidStopChanging @subscribeToBuffer
    @subscriptions.add @editorView.onDidAttach @subscribeToBuffer

    @subscriptions.add @editor.onDidDestroy =>
      @unsubscribeFromBuffer()
      @subscriptions.dispose()

    @subscribeToBuffer()

  watchConfigChanges: (ignoreCommentedLines) =>
    unless ignoreCommentedLines.newValue == @config.ignoreCommentedLines
      @config.ignoreCommentedLines = ignoreCommentedLines.newValue
      @scheduleUpdate()

  destroy: ->
    @unsubscribeFromBuffer()

  unsubscribeFromBuffer: =>
    if @buffer?
      @removeDecorations()
      @bufferSubscriptions.dispose()
      @buffer = null

  subscribeToBuffer: =>
    @unsubscribeFromBuffer()

    if @buffer = @editor.getBuffer()
      @scheduleUpdate()
      @bufferSubscriptions.add @buffer.onDidChange @updateColors
      @bufferSubscriptions.add @buffer.onDidStopChanging @updateColors

  scheduleUpdate: ->
    setImmediate(@updateColors)

  updateColors: =>
    @removeDecorations()

    # Is one of these more performant?
    # for line, index in @editor.getText().split('\n')
    #   matches = regexp.exec line
    # for line in [0...@editor.getLineCount()]
    #   matches = regexp.exec @editor.lineForBufferRow(line)
    for line in [0...@editor.getLineCount()]
      unless @config.ignoreCommentedLines and @editor.isBufferRowCommented(line)
        for regexp in RegExps
          match = regexp.exec @editor.lineTextForBufferRow(line)
          if match?
            @markLine line, match[1]
            break

  removeDecorations: ->
    return unless @markers?
    marker.destroy() for marker in @markers
    @markers = []

  markLine: (line, color) ->
    marker = @editor.markBufferPosition([line, 0], invalidate: 'never')
    @editor.decorateMarker(marker, type: 'line-number', class: 'color-gutter')
    @editorView.rootElement?.querySelector('.line-number-' + line)?.style.borderRightColor = color;
    @markers.push marker
