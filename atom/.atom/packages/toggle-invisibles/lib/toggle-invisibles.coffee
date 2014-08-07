#
# Copyright (c) 2014 by Lifted Studios. All Rights Reserved.
#

toggleBoth = ->
  if atom.config.get('editor.showInvisibles') and atom.config.get('editor.showIndentGuide')
    atom.config.set 'editor.showInvisibles', no
    atom.config.set 'editor.showIndentGuide', no
  else
    atom.config.set 'editor.showInvisibles', yes
    atom.config.set 'editor.showIndentGuide', yes

toggleInvisibles = ->
  atom.config.toggle 'editor.showInvisibles'

toggleIndentGuide = ->
  atom.config.toggle 'editor.showIndentGuide'

module.exports =
  activate: (state) ->
    # keep toggle-invisibles:toggle the same for backwards compatibility
    atom.workspaceView.command 'toggle-invisibles:toggle', -> toggleInvisibles()
    atom.workspaceView.command 'toggle-invisibles:toggleBoth', -> toggleBoth()
    atom.workspaceView.command 'toggle-invisibles:toggleInvisibles', -> toggleInvisibles()
    atom.workspaceView.command 'toggle-invisibles:toggleIndentGuide', -> toggleIndentGuide()
