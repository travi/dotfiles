#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    #shellcheck disable=SC1090
   . "$(brew --prefix)/etc/bash_completion"
fi
