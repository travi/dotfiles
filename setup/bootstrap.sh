#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

echo "Bootstrapping machine using travi's dotfiles..."

if [[ "$OSTYPE" == darwin* ]]; then

    echo "Bootstrapping MacOS..."

    if [ "$(which brew)" ]; then
        echo "Homebrew is already installed"
    else
        echo "Installing Homebrew"
        true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
fi
