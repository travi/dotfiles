#!/bin/sh

/bin/bash ../osx/software.sh || return 1
/bin/bash ../windows/software.sh || return 1

if which gem > /dev/null 2>&1; then
    heading 'Ruby Gems'
    gem update
    gem cleanup
fi

if which npm > /dev/null 2>&1; then
    heading "NPM Update"
    npm update -g
fi

if which vim > /dev/null 2>&1; then
    heading "Vundle Install"
    vim +PluginInstall! +qall
fi
