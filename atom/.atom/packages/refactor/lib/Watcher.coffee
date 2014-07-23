{ EventEmitter2 } = require 'eventemitter2'
ReferenceView = require './background/ReferenceView'
ErrorView = require './background/ErrorView'
GutterView = require './gutter/GutterView'
StatusView = require './status/StatusView'
{ locationDataToRange } = require './utils/LocationDataUtil'
{ nextTick } = process

module.exports =
class Watcher extends EventEmitter2

  constructor: (@moduleManager, @editorView) ->
    super()
    @editor = @editorView.editor
    @editor.on 'grammar-changed', @verifyGrammar
    @moduleManager.on 'changed', @verifyGrammar
    @verifyGrammar()

  destruct: =>
    @removeAllListeners()
    @deactivate()
    @editor.off 'grammar-changed', @verifyGrammar
    @moduleManager.off 'changed', @verifyGrammar

    delete @moduleManager
    delete @editorView
    delete @editor
    delete @module

  onDestroyed: =>
    @emit 'destroyed', @


  ###
  Grammar checker
  1. Detect grammar changed.
  2. Destroy instances and listeners.
  3. Exit when grammar isn't CoffeeScript.
  4. Create instances and listeners.
  ###

  verifyGrammar: =>
    @deactivate()
    scopeName = @editor.getGrammar().scopeName
    @module = @moduleManager.getModule scopeName
    return unless @module?
    @activate()

  activate: ->
    # Setup model
    @ripper = new @module.Ripper @editor

    # Setup views
    @referenceView = new ReferenceView
    @editorView.underlayer.append @referenceView
    @errorView = new ErrorView
    @editorView.underlayer.append @errorView
    @gutterView = new GutterView @editorView.gutter
    @statusView = new StatusView

    # Start listening
    @editorView.on 'cursor:moved', @onCursorMoved
    @editor.on 'destroyed', @onDestroyed
    @editor.buffer.on 'changed', @onBufferChanged

    # Execute
    @parse()

  deactivate: ->
    # Stop listening
    @editorView.off 'cursor:moved', @onCursorMoved
    @editor.off 'destroyed', @onDestroyed
    @editor.buffer.off 'changed', @onBufferChanged
    clearTimeout @bufferChangedTimeoutId
    clearTimeout @cursorMovedTimeoutId

    # Destruct instances
    @ripper?.destruct()
    @referenceView?.destruct()
    @errorView?.destruct()
    @gutterView?.destruct()
    @statusView?.destruct()

    # Remove references
    delete @bufferChangedTimeoutId
    delete @cursorMovedTimeoutId
    delete @module
    delete @ripper
    delete @referenceView
    delete @errorView
    delete @gutterView
    delete @statusView


  ###
  Reference finder process
  1. Stop listening cursor move event and reset views.
  2. Parse.
  3. Show errors and exit process when compile error is thrown.
  4. Show references.
  5. Start listening cursor move event.
  ###

  parse: =>
    @editorView.off 'cursor:moved', @onCursorMoved
    @hideError()
    @referenceView.update()

    text = @editor.buffer.getText()
    if text isnt @cachedText
      @cachedText = text
      @ripper.parse text, (err) =>
        if err?
          @showError err
          return
        @hideError()
        @onParseEnd()
    else
      @onParseEnd()

  showError: ({ location, message }) =>
    return unless location?
    range = locationDataToRange location
    err =
      range  : range
      message: message
    @errorView.update [ @rangeToRows range ]
    @gutterView.update [ err ]

  hideError: =>
    @errorView.update()
    @gutterView.update()

  onParseEnd: =>
    @updateReferences()
    @editorView.off 'cursor:moved', @onCursorMoved
    @editorView.on 'cursor:moved', @onCursorMoved

  updateReferences: =>
    ranges = []
    cursor = @editor.cursors[0]
    if cursor?
      range = cursor.getCurrentWordBufferRange includeNonWordCharacters: false
      unless range.isEmpty()
        ranges = @ripper.find range.start
    rowsList = for range in ranges
      @rangeToRows range
    @referenceView.update rowsList


  ###
  Rename process
  1. Detect rename command.
  2. Cancel and exit process when cursor is moved out from the symbol.
  3. Detect done command.
  ###

  rename: ->
    return false unless @isActive()

    cursor = @editor.cursors[0]
    range = cursor.getCurrentWordBufferRange includeNonWordCharacters: false
    refRanges = @ripper.find range.start
    return false if refRanges.length is 0

    # Save cursor info.
    # Select all references.
    # Listen to cursor moved event.
    @renameInfo =
      cursor: cursor
      range : range
    for refRange in refRanges
      @editor.addSelectionForBufferRange refRange
    @editorView.off 'cursor:moved', @cancel
    @editorView.on 'cursor:moved', @cancel
    true

  cancel: =>
    return if not @renameInfo? or
                  @renameInfo.range.start.isEqual @renameInfo.cursor.getCurrentWordBufferRange(includeNonWordCharacters: false).start

    # Set cursor position to current position.
    # Stop listening cursor moved event.
    # Destroy cursor info.
    @editor.setCursorBufferPosition @renameInfo.cursor.getBufferPosition()
    @editorView.off 'cursor:moved', @cancel
    delete @renameInfo

  done: ->
    return false unless @isActive()
    return false unless @renameInfo?

    # Set cursor position to current position.
    # Stop listening cursor moved event.
    # Destroy cursor info.
    @editor.setCursorBufferPosition @renameInfo.cursor.getBufferPosition()
    @editorView.off 'cursor:moved', @cancel
    delete @renameInfo
    true


  ###
  User events
  ###

  onBufferChanged: =>
    clearTimeout @bufferChangedTimeoutId
    @bufferChangedTimeoutId = setTimeout @parse, 0

  onCursorMoved: =>
    clearTimeout @cursorMovedTimeoutId
    @cursorMovedTimeoutId = setTimeout @updateReferences, 0


  ###
  Utility
  ###

  isActive: ->
    @module? and atom.workspaceView.getActivePaneItem() is @editor

  # Range to pixel based start and end range for each row.
  rangeToRows: ({ start, end }) ->
    for raw in [start.row..end.row] by 1
      rowRange = @editor.buffer.rangeForRow raw
      point =
        left : if raw is start.row then start else rowRange.start
        right: if raw is end.row then end else rowRange.end
      pixel =
        tl: @editorView.pixelPositionForBufferPosition point.left
        br: @editorView.pixelPositionForBufferPosition point.right
      pixel.br.top += @editorView.lineHeight
      pixel
