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
brew update
brew prune
brew doctor
brew tap homebrew/boneyard
brew bundle-old ~/.dotfiles/osx/Brewfile
if [ -e ~/.dotfiles.extra/osx/Brewfile ]; then
    brew bundle-old ~/.dotfiles.extra/osx/Brewfile
fi

heading 'Brew Cask bundle'
brew bundle-old ~/.dotfiles/osx/Caskfile
if [ -e ~/.dotfiles.extra/osx/Caskfile ]; then
    brew bundle-old ~/.dotfiles.extra/osx/Caskfile
fi

if [[ ! -d ~/.nvm ]]; then
    heading "Finishing nvm configuration"

    mkdir ~/.nvm
    cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
fi

heading 'Ruby Gems'
gem update
gem cleanup
