#!/bin/bash

. functions.sh

info 'link dotfiles'
link_dotfiles_directory
link_dotfiles

info 'Brew bundle'
brew bundle
info 'Brew Cask bundle'
brew bundle Caskfile

info 'Bundle install'
gem install bundler
gem update --system
gem update
bundle install
