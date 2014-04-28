#!/bin/bash

DOTFILES_ROOT="`pwd`"

info () {
    printf "  [ \033[00;34m..\033[0m ] $1"
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

link_file () {
    ln -s $1 $2
    success "linked $1 to $2"
}

dotfile () {
    source=$1
    dest="$HOME/.${source##*.}"

    if [ -f $dest ] || [ -d $dest ]
    then
	    fail "already exists"
    else
	    link_file "$HOME/.dotfiles/$source" $dest
    fi
}

info 'link dotfiles'
link_file $DOTFILES_ROOT "$HOME/.dotfiles"
dotfile 'vim/.vimrc'

info 'Brew bundle'
brew bundle

#should check for existence of ~/.dotfiles
#if not there, ask for path to clone the git repository to
#and add a simlink at ~/.dotfiles
