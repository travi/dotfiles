#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

export PATH
export M2_HOME
export M2

PATH=/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
PATH=$(brew --prefix gnupg)/bin:$(brew --prefix ruby)/bin:$(brew --prefix python)/libexec/bin:~/.local/bin:$PATH
M2_HOME=$(brew --prefix maven)/libexec
M2="${M2_HOME}/bin"

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=/Library/Fonts --screen_saverdir=/Library/Screen\\ Savers --require-sha";

export HOMEBREW_NO_INSECURE_REDIRECT=1

export GRC_ALIASES=true

export FORCE_COLOR=1
export NPM_CONFIG_COLOR=always
