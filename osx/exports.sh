#!/bin/sh

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

export PATH=/usr/local/bin:$(brew --prefix ruby)/bin:$PATH
export M2_HOME=$(brew --prefix maven31)/libexec
export M2="${M2_HOME}/bin"
export PYTHONPATH=$(brew --prefix mercurial)/lib/python2.7/site-packages:$(brew --prefix mercurial)/lib/python2.7/site-packages/mercurial:$PYTHONPATH

# Link Homebrew casks in `/Applications` rather than `~/Applications`
#export HOMEBREW_CASK_OPTS="--appdir=/Applications";
