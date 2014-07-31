# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

info 'Brew bundle'
brew bundle

info 'Brew Cask bundle'
brew bundle Caskfile
