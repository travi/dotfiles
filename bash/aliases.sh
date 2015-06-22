#!/bin/sh

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
elif ls -G > /dev/null 2>&1; then # OS X `ls`
    colorflag="-G"
else
    colorflag=""
fi

alias ls="ls ${colorflag} -F"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"

alias hosts="sudo $EDITOR /etc/hosts"

alias reload='. ~/.bash_profile'

alias ccat="source-highlight --out-format=esc -o STDOUT -i"

. $HOME/.dotfiles/osx/aliases.sh
