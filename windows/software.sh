#!/bin/bash

. ~/.dotfiles/setup/functions.sh

# Windows-only stuff. Abort if not Windows.
[[ -n "$WINDIR" ]] || return 1

heading 'Installing/Updating Chocolatey Packages'
choco install ../windows/packages.config -y
choco upgrade all -y
