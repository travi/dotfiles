{ScrollView} = require 'atom'

module.exports =
class NpmDocsView extends ScrollView
  atom.deserializers.add(this)

  @deserialize: ({path})->
    new NpmDocsView(path)

  @content: ->
    @div class: 'npm-docs native-key-bindings', tabindex: -1

  constructor: (@path) ->
    super
    @handleEvents()

  renderContents: (html) ->
    @html(html)

  serialize: ->
    deserializer: 'NpmDocsView'
    path: @path

  handleEvents: ->
    @subscribe this, 'core:move-up',   => @scrollUp()
    @subscribe this, 'core:move-down', => @scrollDown()

  # Tear down any state and detach
  destroy: ->
    @unsubscribe()

  getTitle: ->
    "npm-docs: #{@path}"
