#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

echo "Bootstrapping machine using travi's dotfiles..."

if [[ "$OSTYPE" == darwin* ]]; then

    echo "Bootstrapping MacOS..."

    # Ask for the administrator password upfront
    sudo -v

    if [ "$(which brew)" ]; then
        echo "Homebrew is already installed"
    else
        echo "Installing Homebrew"
        true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    if [ ! -d "$HOME/development/travi/dotfiles" ]; then
        if [ -d "$HOME/development/travi" ]; then
            echo "Parent directory already exists to house the dotfiles repo"
        else
            echo "Creating parent directory to house the dotfiles repo"
            mkdir -p "$HOME/development/travi"
        fi

        cd "$HOME/development/travi"

        echo "Cloning the dotfiles repo"
        git clone https://github.com/travi/dotfiles.git
    else
        echo "dotfiles repo already cloned"
    fi

else
    echo "Bootstrapping for this OS ($OSTYPE) has not been implemented yet"
fi
