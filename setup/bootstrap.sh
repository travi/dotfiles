#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

clone() {
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
}

install() {
    cd "$HOME/development/travi/dotfiles/setup"

    echo "Installing the dotfiles"
    source init.sh
}

echo "Bootstrapping machine using travi's dotfiles..."

if [[ "$OSTYPE" == darwin* ]]; then

    echo "Bootstrapping MacOS..."

    # Ask for the administrator password upfront
    # sudo -v

    if [ "$(command -v brew)" ]; then
        echo "Homebrew is already installed"
    else
        echo "Installing Homebrew"

        #Skip the "Press enter to continue…" prompt.
        true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    clone

    install

elif [[ "$OSTYPE" == "linux-musleabihf" ]]; then

    echo "Bootstrapping Raspberry Pi OS (musl)..."

    clone

    install

elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then

    echo "Bootstrapping Raspberry Pi OS (gnu)..."

    clone

    install

else
    echo "Bootstrapping for this OS ($OSTYPE) has not been implemented yet"
fi
