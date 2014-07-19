# {WorkspaceView} = require 'atom'
# Refactor = require '../lib/refactor'
#
# describe "Refactor", ->
#   activationPromise = null
#
#   beforeEach ->
#     atom.workspaceView = new WorkspaceView
#     activationPromise = atom.packages.activatePackage 'refactor'
#
#   describe "when the refactor:toggle event is triggered", ->
#     it "attaches and then detaches the view", ->
#       expect(atom.workspaceView.find('.refactor-reference')).not.toExist()
#       atom.workspaceView.trigger 'refactor:rename'
#
#       waitsForPromise ->
#         activationPromise
#
#       runs ->
#         expect(atom.workspaceView.find('.refactor-reference')).toExist()
#         atom.workspaceView.trigger 'refactor:rename'
#         expect(atom.workspaceView.find('.refactor-reference')).not.toExist()
