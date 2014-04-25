#!/bin/bash

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

info 'Brew bundle'
brew bundle
