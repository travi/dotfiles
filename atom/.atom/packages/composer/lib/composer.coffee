fs = require 'fs'
path = require 'path'
{spawn} = require 'child_process'

ComposerView = require './composer-view'

module.exports =
    configDefaults:
        composerExecutablePath: '/usr/local/bin/composer'

    activate: ->
        atom.workspaceView.command "composer:about", => @about()
        atom.workspaceView.command "composer:archive", => @archive()
        atom.workspaceView.command "composer:dumpautoload", => @dumpautoload()
        atom.workspaceView.command "composer:runscript", => @runscript()
        atom.workspaceView.command "composer:validate", => @validate()
        atom.workspaceView.command "composer:install", => @install()
        atom.workspaceView.command "composer:update", => @update()
        atom.workspaceView.command "composer:init", => @init()

    about: ->
        command = 'about'
        @runner(command)

    archive: ->
        command = 'archive'
        @runner(command)

    dumpautoload: ->
        command = 'dumpautoload'
        @runner(command)

    runscript: ->
        command = 'run-script'
        @runner(command)

    install: ->
        command = 'install'
        @runner(command)

    update: ->
        command = 'update'
        @runner(command)

    validate: ->
        command = 'validate'
        @runner(command)

    init: ->
        command = 'init'
        @runner(command)

    runner: (command, options) ->
        composerPanel = atom.workspaceView.find(".composer-container")
        composerView = new ComposerView
        atom.workspaceView.find(".composer-contents").html("")
        atom.workspaceView.prependToBottom composerView unless composerPanel.is(":visible")

        projectPath = atom.project.getPath()
        composer = atom.config.get "composer.composerExecutablePath"
        tail = spawn(composer, [command + ' -d ' + projectPath])

        tail.stdout.on "data", (data) =>
            data = @replacenl(data)
            @writeToPanel(data)

        tail.stderr.on "data", (data) ->
            console.log "stderr: " + data

        tail.on "close", (code) =>
            @writeToPanel "<br>Complete<br>"
            console.log "child process exited with code " + code

    writeToPanel: (data) ->
        atom.workspaceView.find(".composer-contents").append("#{data}").scrollToBottom()

    replacenl: (replaceThis) ->
        breakTag = "<br>"
        data = (replaceThis + "").replace /([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, "$1" + breakTag + "$2"
        return data
