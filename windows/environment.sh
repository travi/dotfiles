#!/bin/bash

# Windows-only stuff. Abort if not Windows.
[[ -n "$WINDIR" ]] || return 1

heading 'Configuring ConEmu'
link_file "$HOME/.dotfiles/windows/ConEmu.xml" "$HOME/AppData/Roaming/ConEmu.xml"
