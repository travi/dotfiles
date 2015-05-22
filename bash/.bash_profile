#!/bin/sh

. ~/.dotfiles/bash/source.sh

if [ -e ~/.dotfiles.extra/bash/source.sh ]; then
    . ~/.dotfiles.extra/bash/source.sh
fi
