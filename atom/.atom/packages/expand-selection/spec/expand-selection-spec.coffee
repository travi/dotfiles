{WorkspaceView} = require 'atom'
ExpandSelection = require '../lib/expand-selection'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "ExpandSelection", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('expand-selection')

  describe "when the expand-selection:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.expand-selection')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'expand-selection:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.expand-selection')).toExist()
        atom.workspaceView.trigger 'expand-selection:toggle'
        expect(atom.workspaceView.find('.expand-selection')).not.toExist()
