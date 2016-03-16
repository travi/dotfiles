#!/bin/bash

# Windows-only stuff. Abort if not Windows.
[[ -n "$WINDIR" ]] || return 1

heading 'Installing/Updating Chocolatey Packages'
choco installmissing packages.config
choco update all
