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

heading 'Extending Maven'
link_maven_extensions

. osx/osx.sh