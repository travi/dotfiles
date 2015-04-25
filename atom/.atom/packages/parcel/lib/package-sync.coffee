fs = require 'fs'

{BufferedProcess} = require 'atom'

PackageList = require './package-list'
StatusMessage = require './status-message'

# Public: Performs the package synchronization.
#
# ## Events
#
# This class has no events.
module.exports =
class PackageSync
  # Internal: Path to `apm`.
  apmPath: atom.packages.getApmPath()

  # Internal: Process object of the current install.
  currentInstall: null
  # Internal: Packages in the process of being installed.
  packagesToInstall: []
  # Internal: Process object of the current uninstall.
  currentUninstall: null
  # Internal: Packages in the process of being uninstalled.
  packagesToUninstall: []

  # Internal: Timeout for messages that should be up for only a short time.
  shortMessageTimeout: 1000
  # Internal: Timeout for messages that should be up longer.
  longMessageTimeout: 15000
  # Internal: Status bar message.
  message: null
  # Internal: Timeout for status bar message.
  timeout: null

  # Public: Uninstalls any packages removed from the `packages.cson`
  # configuration file and installs any packages in the `packages.cson`
  # configuration file that are not installed.
  sync: ->
    packageList = new PackageList()
    if packageList.getPackages().length > 0
      # Uninstall packages removed from `packages.cson`
      removed = @getRemovedPackages()
      @uninstallPackages(removed)
      # Install packages in `packages.cson` that are not installed
      missing = @getMissingPackages()
      @installPackages(missing)
    else
      @writePackageList()

  # Public: Writes the current package list to the `packages.cson` configuration file.
  writePackageList: ->
    new PackageList().setPackages()
    @displayMessage('Package list written to packages.cson')

  # Internal: Displays a message in the status bar.
  #
  # If `timeout` is specified, the message will automatically be cleared in `timeout` milliseconds.
  #
  # message - A {String} containing the message to be displayed.
  # timeout - An optional {Number} specifying the time in milliseconds until the message will be
  #           cleared.
  displayMessage: (message, timeout) ->
    console.log('Parcel: ' + message)
    clearTimeout(@timeout) if @timeout?
    if @message?
      @message.setText(message)
    else
      @message = new StatusMessage(message)

    @setMessageTimeout(timeout) if timeout?

  # Internal: Execute APM to install the given package.
  #
  # pkg - A {String} containing the name of the package to install.
  apmInstall: (pkg) ->
    @displayMessage("Installing #{pkg}")
    command = @apmPath
    args = ['install', pkg]
    stdout = (output) ->
    stderr = (output) ->
    exit = (exitCode) =>
      if exitCode is 0
        if @packagesToInstall.length > 0
          @displayMessage("#{pkg} installed!", @shortMessageTimeout)
        else
          @displayMessage('Package installation complete!', @longMessageTimeout)
      else
        @displayMessage("An error occurred installing #{pkg}", @longMessageTimeout)

      @currentInstall = null
      @installPackage()

    @currentInstall = new BufferedProcess({command, args, stdout, stderr, exit})

  # Internal: Execute APM to uninstall the given package.
  #
  # pkg - A {String} containing the name of the package to uninstall.
  apmUninstall: (pkg) ->
    @displayMessage("Uninstalling #{pkg}")
    command = @apmPath
    args = ['uninstall', pkg]
    stdout = (output) ->
    stderr = (output) ->
    exit = (exitCode) =>
      if exitCode is 0
        if @packagesToUninstall.length > 0
          @displayMessage("#{pkg} uninstalled!", @shortMessageTimeout)
        else
          @displayMessage('Package uninstallation complete!', @longMessageTimeout)
      else
        @displayMessage("An error occurred uninstalling #{pkg}", @longMessageTimeout)

      @currentUninstall = null
      @uninstallPackage()

    @currentUninstall = new BufferedProcess({command, args, stdout, stderr, exit})

  # Internal: Gets the list of packages that are missing.
  #
  # Returns an {Array} of names of packages that need to be installed.
  getMissingPackages: ->
    list = new PackageList()
    packageList = list.getPackages()
    availablePackages = atom.packages.getAvailablePackageNames()
    value for value in packageList when value not in availablePackages

  # Internal: Installs the next package in the list.
  installPackage: ->
    # Exit if there is already an installation running or if there are no more
    # packages to install.
    if @currentInstall? or @packagesToInstall.length is 0
      @displayMessage('There are no additional packages to install from packages.cson.')
    else
      @apmInstall(@packagesToInstall.shift())

  # Internal: Installs each of the packages in the given list.
  #
  # packages - An {Array} containing the names of packages to install.
  installPackages: (packages) ->
    @packagesToInstall.push(packages...)
    @installPackage()

  # Internal: Gets the list of packages that were removed.
  #
  # Returns an {Array} of names of packages that need to be uninstalled.
  getRemovedPackages: ->
    list = new PackageList()
    packageList = list.getPackages()
    availablePackages = atom.packages.getAvailablePackageNames()
    value for value in availablePackages when value not in packageList

  # Internal: Uninstalls the next package in the list.
  uninstallPackage: ->
    # Exit if there is already an installation running or if there are no more
    # packages to uninstall.
    if @currentUninstall? or @packagesToUninstall.length is 0
      @displayMessage('There are no additional packages to uninstall from packages.cson.')
    else
      @apmUninstall(@packagesToUninstall.shift())

  # Internal: Uninstalls each of the packages in the given list.
  #
  # packages - An {Array} containing the names of packages to uninstall.
  uninstallPackages: (packages) ->
    @packagesToUninstall.push(packages...)
    @uninstallPackage()

  # Internal: Sets a timeout to remove the status bar message.
  #
  # timeout - The {Number} of milliseconds until the message should be removed.
  setMessageTimeout: (timeout) ->
    clearTimeout(@timeout) if @timeout?
    @timeout = setTimeout(=>
      @message.remove()
      @message = null
    , timeout)
