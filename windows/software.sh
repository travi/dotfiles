#!/bin/bash

. ~/.dotfiles/setup/functions.sh

# Windows-only stuff. Abort if not Windows.
[[ -n "$WINDIR" ]] || return 1

heading 'Installing/Updating Chocolatey Packages'
choco install ../windows/packages.config -y
if [ -e ~/.dotfiles.extra/windows/packages.config ]; then
    choco install ~/.dotfiles.extra/windows/packages.config -y
fi
choco upgrade all -y
