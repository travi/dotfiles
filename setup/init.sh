#!/bin/bash

. ./functions.sh

# Install Homebrew.
if [[ "$OSTYPE" =~ ^darwin ]] && [[ ! "$(type -P brew)" ]]; then
    heading "Installing Homebrew"

    #Skip the "Press enter to continue…" prompt.
    true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

heading "Linking dotfiles directory"
link_dotfiles_directory

. ./menu.sh
