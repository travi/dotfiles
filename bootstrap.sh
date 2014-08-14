#!/bin/bash

. ./functions.sh

heading 'link dotfiles'
link_dotfiles_directory
link_dotfiles

. osx/apps.sh

heading 'Bundle install'
gem install bundler
gem update --system
gem update
bundle install
