request = require 'request'
CaniuseView = require './caniuse-view'

UPDATE_URL = 'https://raw.githubusercontent.com/Fyrd/caniuse/master/data.json'

isJsonString = (str) ->
    try
      JSON.parse str
      return yes
    return no


module.exports =
  caniuseView: null

  activate: (state) ->
    atom.commands.add 'atom-workspace',
      'can-i-use:show': =>
        @caniuseView ?= new CaniuseView()
        @caniuseView.show()

      'can-i-use:update', =>
        request UPDATE_URL, (error, response, body) =>
          if not error and response.statusCode is 200 and isJsonString(body)
            localStorage['caniuse:data'] = body
            @caniuseView.populate() if @caniuseView
          else
            @caniuseView.setError 'Loading data failed!'

  config:
    showIe:
      title: 'Show IE'
      type: 'boolean'
      default: true
    showFirefox:
      type: 'boolean'
      default: true
    showChrome:
      type: 'boolean'
      default: true
    showSafari:
      type: 'boolean'
      default: true
    showOpera:
      type: 'boolean'
      default: false
    showIosSaf:
      title: 'Show iOS Safari'
      type: 'boolean'
      default: true
    showOpMini:
      title: 'Show Opera Mini'
      type: 'boolean'
      default: false
    showAndroid:
      title: 'Show Android Browser'
      type: 'boolean'
      default: true
    showOpMob:
      title: 'Show Opera Mobile'
      type: 'boolean'
      default: false
    showBb:
      title: 'Show Blackberry Browser'
      type: 'boolean'
      default: false
    showAndChr:
      title: 'Show Chrome for Android'
      type: 'boolean'
      default: true
    showAndFf:
      title: 'Show Firefox for Android'
      type: 'boolean'
      default: false
    showIeMob:
      title: 'Show IE Mobile'
      type: 'boolean'
      default: false
    showAndUc:
      title: 'Show UC Browser for Android'
      type: 'boolean'
      default: false
