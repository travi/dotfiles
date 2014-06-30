#!/bin/bash

DOTFILES_ROOT="`pwd`"

info () {
    printf "  [ \033[00;34m..\033[0m ] $1"
    echo ''
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    exit
}

link_file () {
    ln -s $1 $2
    success "linked $1 to $2"
}

dotfile () {
    source=$1
    filename=`basename $source`
    dest="$HOME/$filename"

    if [ -h $dest ];then
	    success "link $dest already exists"
    elif [ -f $dest ] || [ -d $dest ]
    then
	    fail "$dest already exists"
    else
	    link_file $source $dest
    fi
}

link_dotfiles_directory() {
	#should check for existence of ~/.dotfiles
	#if not there, ask for path to clone the git repository to
	#and add a simlink at ~/.dotfiles
	if [ -h "$HOME/.dotfiles" ]
	then
		success ".dotfiles already linked"
	else
		link_file $DOTFILES_ROOT "$HOME/.dotfiles"
	fi
}

link_dotfiles() {
	DOTFILES_LINK="$HOME/.dotfiles/"
	for source in `find $DOTFILES_LINK -mindepth 2 -maxdepth 2 -name '\.*'`
	do
		dotfile ${source}
	done
}
