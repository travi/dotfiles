# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

source $(brew --prefix nvm)/nvm.sh
