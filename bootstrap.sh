#!/bin/bash

shopt -s expand_aliases
. ./bash/aliases.sh

. ./functions.sh

heading 'Link Dotfiles'
link_dotfiles_directory
link_dotfiles

heading 'Improving Bash'
source_scripts
reload

. osx/apps.sh

heading 'Extending Maven'
link_maven_extensions

heading 'Bundle Install'
gem install bundler
gem update --system
gem update
bundle install
