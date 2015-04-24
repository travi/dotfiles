PackageSync = null
packageSync = null

loadModule = ->
  PackageSync ?= require './package-sync'
  packageSync ?= new PackageSync()

sync = ->
  loadModule()
  packageSync.sync()

writePackageList = ->
  loadModule()
  packageSync.writePackageList()

module.exports =
  activate: ->
    # Register parcel:sync command to run sync()
    atom.workspaceView.command 'parcel:sync', ->
      sync()
    # Automatically run sync() when activated
    sync()
  deactivate: ->
    writePackageList()
