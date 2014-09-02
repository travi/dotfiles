#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

heading 'Brew bundle'
brew doctor
brew bundle $HOME/.dotfiles/Brewfile

heading 'Brew Cask bundle'
brew bundle $HOME/.dotfiles/Caskfile
