#!/bin/sh

. ../osx/software.sh

heading "Vundle Install"
vim +PluginInstall! +qall
