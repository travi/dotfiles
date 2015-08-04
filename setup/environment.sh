#!/bin/bash

heading 'Link Dotfiles'
link_dotfiles
link_gitconfig_for_os
reload

heading 'Extending Maven'
link_maven_extensions

. ../osx/environment.sh
