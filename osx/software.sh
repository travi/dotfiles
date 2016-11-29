#!/bin/bash

#shellcheck disable=SC1090
. ~/.files/setup/functions.sh

set -euo pipefail
IFS=$'\n\t'

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || exit 1

# Ask for the administrator password upfront
sudo -v

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    heading "Installing Homebrew"

    #Skip the "Press enter to continue…" prompt.
    true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

heading 'Brew bundle'
brew update
brew prune
brew doctor || exit 1
brew tap homebrew/boneyard
brew bundle-old ~/.files/osx/Brewfile
if [ -e ~/.files.extra/osx/Brewfile ]; then
    brew bundle-old ~/.files.extra/osx/Brewfile
fi

heading 'Brew Cask bundle'
brew bundle-old ~/.files/osx/Caskfile
if [ -e ~/.files.extra/osx/Caskfile ]; then
    brew bundle-old ~/.files.extra/osx/Caskfile
fi

if [[ ! -d ~/.nvm ]]; then
    heading "Finishing nvm configuration"

    mkdir ~/.nvm
    cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
fi
