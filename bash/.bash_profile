#!/bin/sh

. ~/.files/bash/source.sh

if [ -e ~/.files.extra/bash/source.sh ]; then
    . ~/.files.extra/bash/source.sh
fi

if [ -s "$HOME/.avn/bin/avn.sh" ]; then
  . "$HOME/.avn/bin/avn.sh" # load avn
fi
