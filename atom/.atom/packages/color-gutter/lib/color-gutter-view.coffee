{Subscriber} = require 'emissary'
RegExps = require './color-gutter-regexps'

module.exports =
class ColorGutterView
  Subscriber.includeInto(this)

  constructor: (@editorView) ->
    {@editor, @gutter} = @editorView
    @decorations = {}
    @markers = null

    @config =
      ignoreCommentedLines: atom.config.get 'color-gutter.ignoreCommentedLines'

    @watchConfigChanges()

    @subscribe @editorView, 'editor:path-changed', @subscribeToBuffer()

    @subscribe @editorView, 'editor:will-be-removed', =>
      @unsubscribe()
      @unsubscribeFromBuffer()

  watchConfigChanges: =>
    @subscribe atom.config.observe 'color-gutter.ignoreCommentedLines', (ignoreCommentedLines) =>
      unless ignoreCommentedLines == @config.ignoreCommentedLines
        @config.ignoreCommentedLines = ignoreCommentedLines
        @scheduleUpdate()

  destroy: ->
    @unsubscribeFromBuffer()

  unsubscribeFromBuffer: ->
    if @buffer?
      @removeDecorations()
      @buffer.off 'contents-modified', @updateColors
      @buffer = null

  subscribeToBuffer: ->
    @unsubscribeFromBuffer()

    if @buffer = @editor.getBuffer()
      @scheduleUpdate()
      @buffer.on 'contents-modified', @updateColors

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
          match = regexp.exec @editor.lineForBufferRow(line)
          if match?
            @markLine line, match[1]
            break

  removeDecorations: ->
    return unless @markers?
    marker.destroy() for marker in @markers
    @markers = null

  markLine: (line, color) ->
    marker = @editor.markBufferRange([[line, 0], [line, Infinity]], invalidate: 'never')
    @editor.decorateMarker(marker, type: 'gutter', class: 'color-gutter')
    @editorView.find('.line-number-' + line).css({ 'border-right-color': color })
    @markers ?= []
    @markers.push marker
