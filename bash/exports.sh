#!/bin/sh

. "$HOME/.dotfiles/osx/exports.sh"
. "$HOME/.dotfiles/windows/exports.sh"

# Make vim the default editor
export EDITOR="vim";

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Don’t clear the screen after quitting a manual page
#export MANPAGER="less -X";
export MANPAGER="less";
