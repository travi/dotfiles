#!/bin/bash

DOTFILES_ROOT="`pwd`"

. "$DOTFILES_ROOT/bash/colors.sh"

heading () {
    printf "\n         ${yellow}$1${reset}\n"
}

info () {
     printf "  [ ${blue}..${reset} ] $1\n"
}

success () {
    printf "  [ ${green}OK${reset} ] $1\n"
}

warn () {
    printf "  [${orange}WARN${reset}] $1\n"
}

fail () {
    printf "  [${red}FAIL${reset}] $1\n"
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
	    info "link $dest already exists"
    elif [ -f $dest ] || [ -d $dest ]
    then
	    warn "$dest already exists"
    else
	    link_file $source $dest
    fi
}

link_dotfiles_directory() {
	if [ -h "$HOME/.dotfiles" ]
	then
		info ".dotfiles already linked"
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

source_scripts() {
    local profile

    if [ -e $profile ]; then
        info ".bash_profile already exists"
    else
        touch $profile
        echo ". $HOME/.dotfiles/bash/source.sh" >> $profile
    fi
}
