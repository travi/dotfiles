#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
   . "$(brew --prefix)/etc/bash_completion"
fi
