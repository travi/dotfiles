#!/bin/sh

. ~/.dotfiles/bash/colors.sh
. ~/.dotfiles/bash/completion.sh

. ~/.dotfiles/bash/aliases.sh
. ~/.dotfiles/bash/exports.sh

. ~/.dotfiles/git/functions.sh

. ~/.dotfiles/bash/prompt.sh

[ -f /Users/admin/.travis/travis.sh ] && . /Users/admin/.travis/travis.sh
