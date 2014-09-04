#!/bin/bash

heading 'Link Dotfiles'
link_dotfiles

heading 'Improving Bash'
source_scripts
reload

heading 'Extending Maven'
link_maven_extensions

. ../osx/environment.sh