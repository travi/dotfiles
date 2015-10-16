#!/bin/sh

. $HOME/.dotfiles/bash/colors.sh
. ~/.dotfiles/bash/completion.sh

. ~/.dotfiles/bash/aliases.sh
. ~/.dotfiles/bash/functions.sh
. ~/.dotfiles/bash/exports.sh

. ~/.dotfiles/git/functions.sh
. ~/.dotfiles/ruby/rbenv-init.sh

. ~/.dotfiles/bash/prompt.sh

. ~/.dotfiles/osx/source.sh

[ -f ~/.travis/travis.sh ] && . ~/.travis/travis.sh
