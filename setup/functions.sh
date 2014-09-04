#!/bin/bash

DOTFILES_ROOT="`pwd`/../"
DOTFILES_LINK="$HOME/.dotfiles"

. ../bash/colors.sh

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
    return 8
}

link_file() {
    local link_target=$1
    local link_name=$2

    # is a broken symbolic link
    if [ -h ${link_name} ] && [ ! -e ${link_name} ]; then
        warn "Removing broken link for ${link_name}"
        rm ${link_name}
    fi

    # is a symbolic link
    if [ -h ${link_name} ]; then
        info "${link_name} already linked"
    # is a real file or directory
    elif [ -f ${link_name} ] || [ -d ${link_name} ]; then
        warn "${link_name} already exists"
    # safe to create symbolic link
    else
        ln -s ${link_target} ${link_name}
        success "linked ${link_target} to ${link_name}"
    fi
}

link_dotfile() {
    local source=$1
    local filename=`basename ${source}`
    local dest="$HOME/$filename"

    link_file ${source} ${dest}
}

link_dotfiles_directory() {
    link_file ${DOTFILES_ROOT} ${DOTFILES_LINK}
}

link_dotfiles() {
    local source;

    for source in `find ${DOTFILES_LINK}/ -mindepth 2 -maxdepth 2 -name '\.*' -not -path '*/.dotfiles//\.*'`
    do
        link_dotfile ${source}
    done
}

link_maven_extensions() {
    local source;
    local extension;

    if [ -z $M2_HOME ]; then
        warn "M2_HOME environment variable not set"
    else
        for source in `find ${DOTFILES_LINK}/maven/extensions -mindepth 1 -maxdepth 1`
        do
            extension=`basename ${source}`
            link_file ${source} "$M2_HOME/lib/ext/${extension}"
        done
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
