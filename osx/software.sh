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
brew bundle ~/.dotfiles/osx/Brewfile

heading 'Brew Cask bundle'
brew bundle ~/.dotfiles/osx/Caskfile

if [[ ! -d ~/.nvm ]]; then
    heading "Finishing nvm configuration"

    mkdir ~/.nvm
    cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
fi

heading 'Ruby Gems'
gem update
gem cleanup
