#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

export PATH=/usr/local/bin:/usr/local/sbin:$(brew --prefix ruby)/bin:~/.local/bin:$PATH
export M2_HOME=$(brew --prefix maven)/libexec
export M2="${M2_HOME}/bin"
export PYTHONPATH=$(brew --prefix mercurial)/lib/python2.7/site-packages:$(brew --prefix mercurial)/lib/python2.7/site-packages/mercurial:$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH

export NVM_DIR=~/.nvm

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications";
