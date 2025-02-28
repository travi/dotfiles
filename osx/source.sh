#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

NVM_DIR="$(realpath "$HOME"/.nvm)"
export NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

[[ -s ~/.avn/bin/avn.sh ]] && source ~/.avn/bin/avn.sh

source "$(brew --prefix)/etc/bash_completion"
