{ Context } = require '../vender/esrefactor'
{ parse } = require 'esprima'
{ Range } = require 'atom'

module.exports =
class Ripper

  @locToRange: ({ start, end }) ->
    new Range [ start.line - 1, start.column ], [ end.line - 1, end.column ]

  @scopeNames: [
    'source.js'
  ]

  parseOptions:
    loc: true
    range: true
    tokens: true
    tolerant: true

  constructor: (@editor) ->
    @context = new Context

  destruct: ->
    delete @editor
    delete @context

  parse: (code, callback) ->
    try
      syntax = parse code, @parseOptions
      @context.setCode syntax
      callback null
    catch err
      callback err

  find: (range) ->
    pos = 0
    row = range.start.row
    while --row >= 0
      pos += 1 + @editor.lineLengthForBufferRow row
    pos += range.start.column

    identification = @context.identify pos
    return [] unless identification

    { declaration, references } = identification
    if declaration?
      references.unshift declaration
    ranges = []
    for reference in references
      ranges.push Ripper.locToRange reference.loc
    ranges
