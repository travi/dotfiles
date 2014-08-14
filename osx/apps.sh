# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

heading 'Brew bundle'
brew bundle

heading 'Brew Cask bundle'
brew bundle Caskfile
