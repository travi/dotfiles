{WorkspaceView} = require 'atom'
ColorGutter = require '../lib/color-gutter'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "ColorGutter", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('color-gutter')

  describe "when the color-gutter:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.color-gutter')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'color-gutter:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.color-gutter')).toExist()
        atom.workspaceView.trigger 'color-gutter:toggle'
        expect(atom.workspaceView.find('.color-gutter')).not.toExist()
