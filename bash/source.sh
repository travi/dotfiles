#!/bin/sh

#shellcheck disable=SC1090
. ~/.dotfiles/bash/colors.sh
#shellcheck disable=SC1090
. ~/.dotfiles/bash/completion.sh

#shellcheck disable=SC1090
. ~/.dotfiles/bash/aliases.sh
#shellcheck disable=SC1090
. ~/.dotfiles/bash/functions.sh
#shellcheck disable=SC1090
. ~/.dotfiles/bash/exports.sh

#shellcheck disable=SC1090
. ~/.dotfiles/git/functions.sh
#shellcheck disable=SC1090
. ~/.dotfiles/ruby/rbenv-init.sh

#shellcheck disable=SC1090
. ~/.dotfiles/bash/prompt.sh

#shellcheck disable=SC1090
. ~/.dotfiles/osx/source.sh
#shellcheck disable=SC1090
. ~/.dotfiles/windows/source.sh

#shellcheck disable=SC1090
[ -f ~/.travis/travis.sh ] && . ~/.travis/travis.sh
