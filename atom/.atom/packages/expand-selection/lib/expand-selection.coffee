_ = require 'underscore-plus'
{Range} = require 'atom'
{Subscriber} = require 'emissary'

startPairMatches =
  '(': ')'
  '[': ']'
  '{': '}'

endPairMatches =
  ')': '('
  ']': '['
  '}': '{'

pairRegexes = {}
for startPair, endPair of startPairMatches
  pairRegexes[startPair] =
    new RegExp("[#{_.escapeRegExp(startPair + endPair)}]", 'g')

module.exports =
class ExpandSelection
  Subscriber.includeInto(this)

  stringScope: 'string.quoted.'
  whitespaces: /^[ \t]*/

  # Bracket matching regexes.
  combinedRegExp: /[\(\[\{\)\]\}]/g
  startPairRegExp: /[\(\[\{]/g
  endPairRegExp: /[\)\]\}]/g

  constructor: ->
    @subscribeToCommand atom.workspaceView, 'expand-selection:expand', =>
      if editor = atom.workspace.getActiveEditor()
        @expand(editor)

  destroy: ->
    @unsubscribe()

  # Find a suitable open bracket in the editor from a given position backward.
  # Borrowed some code from the atom's bracket-matcher package.
  findAnyStartPair: (editor, fromPosition) ->
    scanRange = new Range([0, 0], fromPosition)
    startPosition = null
    unpairedCount = 0
    editor.backwardsScanInBufferRange @combinedRegExp, scanRange,
      ({match, range, stop}) =>
        if match[0].match(@endPairRegExp)
          unpairedCount++
        else if match[0].match(@startPairRegExp)
          unpairedCount--
          startPosition = range.start
          stop() if unpairedCount < 0
    startPosition

  # Find a matching closed bracket in the editor from a given position.
  # Borrowed some code from the atom's bracket-matcher package.
  findMatchingEndPair: (editor, fromPosition, startPair) ->
    endPair = startPairMatches[startPair]
    scanRange = new Range(fromPosition, editor.buffer.getEndPosition())
    endPairPosition = null
    unpairedCount = 0
    editor.scanInBufferRange pairRegexes[startPair], scanRange,
      ({match, range, stop}) ->
        switch match[0]
          when startPair
            unpairedCount++
          when endPair
            unpairedCount--
            if unpairedCount < 0
              endPairPosition = range.start
              stop()

    endPairPosition?.add([0, 1])

  expand: (editor) ->
    # First of all select the word under cursor if not already selected.
    return editor.selectWordsContainingCursors() if (
      editor.getLastSelection().isEmpty())

    # Iterate over all cursors.
    for cursor in editor.getCursors()
      selection = @getSelectionOnCursor(editor, cursor)
      break if not selection?

      cursorPosition = cursor.getBufferPosition()
      fullRange = cursor.getCurrentLineBufferRange()

      return editor.selectAll() if fullRange.isEqual(selection)

      for scope in cursor.getScopes().slice().reverse()
        # FIXME: Using the display buffer directly may not be the best choice.
        scopeRange = editor.displayBuffer.bufferRangeForScopeAtPosition(scope,
          cursorPosition)

        # Expand to the string except the quotes.
        if scope.indexOf(@stringScope) is 0
          scopeRange = @shrinkRange(scopeRange, 1) if not @isShrinkedRange(
            selection, scopeRange, 1)
        # Scope range is full row.
        else if scope.indexOf('meta.') is 0
          selection.end.column = scopeRange.end.column
        else if scopeRange.containsRange(fullRange)
          # Before selecting the full line check for containing brackets.
          if startPosition = @findAnyStartPair(editor, selection.start)
            startPair = editor.getTextInRange(Range.fromPointWithDelta(
              startPosition, 0, 1))
            endPosition = @findMatchingEndPair(editor, selection.end, startPair)
            # If we found an end position and this range has not been selected
            # already.
            if endPosition? and selection.start isnt startPosition and
                selection.end isnt endPosition
              scopeRange = new Range(startPosition, endPosition)
              scopeRange = @shrinkRange(scopeRange, 1) if not @isShrinkedRange(
                selection, scopeRange, 1)

        # Skip leading white spaces the first time.
        editor.scanInBufferRange @whitespaces, scopeRange,
          ({range}) -> scopeRange.start = range.end
        scopeRange = fullRange if scopeRange.isEqual(selection)

        # Check we are not re-applying the same range and that the new range
        # does really contain the old one.
        if not scopeRange.isEqual(selection) and scopeRange.containsRange(
          selection)
          editor.addSelectionForBufferRange(scopeRange)
          break

  # TODO: This can be optimized for sure.
  # Select selection range.
  getSelectionOnCursor: (editor, cursor) ->
    for range in editor.getSelectedBufferRanges()
      return range if range.containsPoint(cursor.getBufferPosition(), false)

  # Shrink a range by a given amount.
  shrinkRange: (range, amount) ->
    new Range(range.start.add([0, amount]), range.end.add([0, -amount]))

  # Check if range1 is a shrinked version of range2 by a given amount.
  isShrinkedRange: (range1, range2, amount) ->
    range1.start.add([0, -amount]).isEqual(range2.start) and
    range1.end.add([0, amount]).isEqual(range2.end)
