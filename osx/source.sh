#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

#shellcheck disable=SC1090
source "$(brew --prefix nvm)/nvm.sh"
#shellcheck disable=SC1090
source ~/.dotfiles/gpg/init.sh
