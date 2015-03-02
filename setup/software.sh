#!/bin/sh

. ../osx/software.sh

heading "NPM Update"
npm update -g

heading "Vundle Install"
vim +PluginInstall! +qall
