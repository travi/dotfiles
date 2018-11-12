#!/bin/sh

/bin/bash ../osx/software.sh || return 1
/bin/bash ../windows/software.sh || return 1

if [ -d ~/.rbenv ]; then
    rbenv install "$(cat ~/.rbenv/version)" --skip-existing
fi

if command -v gem > /dev/null 2>&1; then
    heading 'Ruby Gems'
    gem update
    gem cleanup
fi

if command -v npm > /dev/null 2>&1; then
    heading "NPM Update"
    npm update -g
fi

if command -v vim > /dev/null 2>&1; then
    heading "Vundle Install"
    vim +PluginInstall! +qall
fi
