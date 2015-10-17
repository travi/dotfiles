#!/bin/sh

. ../osx/software.sh

if [ "$(which gem)" ]; then
    heading 'Ruby Gems'
    gem update
    gem cleanup
fi

if [ "$(which npm)" ]; then
    heading "NPM Update"
    npm update -g
fi

if [ "$(which vim)" ]; then
    heading "Vundle Install"
    vim +PluginInstall! +qall
fi
