#!/bin/sh

/bin/bash ../osx/software.sh

if which gem > /dev/null; then
    heading 'Ruby Gems'
    gem update
    gem cleanup
fi

if which npm > /dev/null; then
    heading "NPM Update"
    npm update -g
fi

if which vim > /dev/null; then
    heading "Vundle Install"
    vim +PluginInstall! +qall
fi
