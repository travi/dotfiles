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
alias ls="ls ${colorflag} -Fh"
alias ll="ls -l"
alias la="ls -A"
alias lla="ls -lA"

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias hosts='sudo $EDITOR /etc/hosts'

alias reload='exec -l $SHELL'

alias ccat="source-highlight --out-format=esc -o STDOUT -i"

alias vim-plugins="vim +PluginInstall! +qall"

. "$HOME/.files/osx/aliases.sh"
