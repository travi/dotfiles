#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

heading 'Brew bundle'
brew doctor
brew tap homebrew/boneyard
brew bundle $HOME/.dotfiles/osx/Brewfile

heading 'Brew Cask bundle'
brew bundle $HOME/.dotfiles/osx/Caskfile

heading 'Ruby Gems'
gem update
gem cleanup
