#!/bin/sh

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
elif ls -G > /dev/null 2>&1; then # OS X `ls`
    colorflag="-G"
else
    colorflag=""
fi

# shellcheck disable=SC2139
alias ls="ls ${colorflag} -F"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"

alias hosts='sudo $EDITOR /etc/hosts'

alias reload='. ~/.bash_profile && bind -f ~/.inputrc'

alias ccat="source-highlight --out-format=esc -o STDOUT -i"

alias vim-plugins="vim +PluginInstall! +qall"

#shellcheck disable=SC1090
. "$HOME/.files/osx/aliases.sh"
