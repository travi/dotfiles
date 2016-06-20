#!/bin/bash

heading 'Link Dotfiles'
link_dotfiles
link_gitconfig_for_os
reload

if [ ! -d ~/bin ]; then
    heading 'Creating ~/bin'
    mkdir ~/bin
fi

heading 'Extending Maven'
link_maven_extensions

. ../osx/environment.sh
. ../windows/environment.sh
