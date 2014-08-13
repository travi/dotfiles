#!/bin/bash

. ./functions.sh

info 'link dotfiles'
link_dotfiles_directory
link_dotfiles

. osx/apps.sh

info 'Bundle install'
gem install bundler
gem update --system
gem update
bundle install
