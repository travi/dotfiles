#!/bin/bash

DOTFILES_ROOT="`pwd`"

. "$DOTFILES_ROOT/bash/colors.sh"

heading() {
    printf "\n${yellow}$1${reset}\n"
}

info() {
    printf "  [ ${blue}..${reset} ] $1\n"
}

success() {
    printf "  [ ${green}OK${reset} ] $1\n"
}

warn() {
    printf "  [${orange}WARN${reset}] $1\n"
}

fail() {
    printf "  [${red}FAIL${reset}] $1\n"
    exit
}

link_file() {
    source=$1
    dest=$2

    # is a broken symbolic link
    if [ -h ${dest} ] && [ ! -e ${dest} ]; then
        warn "Removing broken link for ${dest}"
        rm ${dest}
    fi

    # is a symbolic link
    if [ -h ${dest} ]; then
        info "${dest} already linked"
    # is a real file or directory
    elif [ -f ${dest} ] || [ -d ${dest} ]; then
        warn "${dest} already exists"
    # safe to create symbolic link
    else
        ln -s ${source} ${dest}
        success "linked ${source} to ${dest}"
    fi
}

link_dotfile() {
    source=$1
    filename=`basename $source`
    dest="$HOME/$filename"

    link_file ${source} ${dest}
}

link_dotfiles_directory() {
    link_file ${DOTFILES_ROOT} "$HOME/.dotfiles"
}

link_dotfiles() {
    DOTFILES_LINK="$HOME/.dotfiles/"

    for source in `find ${DOTFILES_LINK} -mindepth 2 -maxdepth 2 -name '\.*'`
    do
        link_dotfile ${source}
    done
}

link_maven_extensions() {
    if [ -z $M2_HOME ]; then
        warn "M2_HOME not set"
    else
        info "M2_HOME set"
    fi
}

source_scripts() {
    local profile="$HOME/.bash_profile"

    if [ -e ${profile} ]; then
        info ".bash_profile already exists"
    else
        touch ${profile}
        echo ". $HOME/.dotfiles/bash/source.sh" >> ${profile}
        . ${profile}
        success "added .bash_profile and sourced configuration files"
    fi
}
