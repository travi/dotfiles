#!/bin/bash

#shellcheck disable=SC1090
. ~/.files/setup/functions.sh

# Windows-only stuff. Abort if not Windows.
[[ -n "${WINDIR-}" ]] || exit 1

heading 'Installing/Updating Chocolatey Packages'
choco install ../windows/packages.config -y
choco upgrade all -y

if [ -e ~/.files.extra/windows/software.sh ]; then
    /bin/bash ~/.files.extra/windows/software.sh
fi
