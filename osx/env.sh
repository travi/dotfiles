#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

# Homebrew: one `brew shellenv` (single fork; handles Intel vs Apple Silicon
# prefix). Kept lean on purpose: this runs for non-interactive shells too, so
# avoid the repeated `brew --prefix` subprocesses used by the interactive
# exports.sh.
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
[ -x /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)"
