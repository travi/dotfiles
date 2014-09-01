#!/bin/sh

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

alias ls="ls ${colorflag}"

alias hosts="sudo $EDITOR /etc/hosts"

alias reload='. ~/.bash_profile'

alias ccat="source-highlight --out-format=esc -o STDOUT -i"

. ~/.dotfiles/osx/aliases.sh
