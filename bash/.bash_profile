#!/bin/sh

. ~/.files/bash/source.sh

if [ -e ~/.files.extra/bash/source.sh ]; then
    . ~/.files.extra/bash/source.sh
fi
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn
