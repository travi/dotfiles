#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

source "$(brew --prefix nvm)/nvm.sh"
source ~/.dotfiles/gpg/init.sh
