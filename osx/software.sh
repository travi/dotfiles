#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    heading "Installing Homebrew"

    #Skip the "Press enter to continue…" prompt.
    true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

heading 'Brew bundle'
brew doctor
brew tap homebrew/boneyard
brew bundle $HOME/.dotfiles/osx/Brewfile

heading 'Brew Cask bundle'
brew bundle $HOME/.dotfiles/osx/Caskfile

heading 'Ruby Gems'
gem update
gem cleanup
