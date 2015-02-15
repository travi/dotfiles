open        = require 'open'
roaster     = require 'roaster'
request     = require 'request'
url         = require 'url'
NpmDocsView = require './npm-docs-view'

module.exports =
  npmDocsView: null

  activate: (state) ->
    atom.workspace.registerOpener (uriToOpen) ->
      {protocol, host} = url.parse(uriToOpen)
      return unless protocol is 'npm-docs:'
      new NpmDocsView(host)

    atom.workspaceView.command "npm-docs:open", =>
      open("https://npmjs.org/package/#{@getSelection()}")

    atom.workspaceView.command "npm-docs:homepage", =>
      @search (err, json, selection) ->
        if (err) then throw err
        open(json.homepage)

    atom.workspaceView.command "npm-docs:readme", =>
      @search (err, json, selection) ->
        if (err) then throw err
        markdown = json.readme
        if !markdown then return
        roaster markdown, {}, (err, contents) ->
          if (err) then throw err
          uri = "npm-docs://#{selection}"
          previousActivePane = atom.workspace.getActivePane()
          atom.workspace.open(uri, split: 'right', searchAllPanes: true).done (npmDocsView) ->
            npmDocsView.renderContents(contents)
            previousActivePane.activate()

  getSelection: ->
    editor = atom.workspace.getActiveEditor()
    editor.getSelection().getText() || editor.getWordUnderCursor()

  search: (cb) ->
    selection = @getSelection()

    request.get "https://registry.npmjs.org/#{selection}", (err, res) ->
      if (err) then throw err

      if res.statusCode == 200
        json = JSON.parse(res.body)
        cb(null, json, selection)
      else
        cb('not found')
