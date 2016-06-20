#!/bin/bash

. ~/.dotfiles/setup/functions.sh

# Windows-only stuff. Abort if not Windows.
[[ -n "$WINDIR" ]] || exit 1

heading 'Installing/Updating Chocolatey Packages'
choco install ../windows/packages.config -y
choco upgrade all -y

if [ -e ~/.dotfiles.extra/windows/software.sh ]; then
    /bin/bash ~/.dotfiles.extra/windows/software.sh
fi
