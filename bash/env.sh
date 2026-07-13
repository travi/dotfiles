#!/bin/bash

# Sourced via $BASH_ENV for non-login, non-interactive shells (e.g. the shell
# GitHub Copilot CLI spawns commands in). Those shells read neither .bashrc
# (interactive-only) nor .bash_profile (login-only), so this is the one hook
# bash offers to make tools reachable there.
#
# Contract: produce NO output, stay fast, and be safe to source repeatedly and
# under `set -u`. Keep it to the essentials needed to find tools; leave prompt,
# aliases, completions, and secrets to the interactive/login files.

# Load once per process tree. Exported so nested non-interactive shells inherit
# the result and skip re-running (nounset-safe via the default expansion).
[ -n "${__NONINTERACTIVE_ENV_LOADED:-}" ] && return
export __NONINTERACTIVE_ENV_LOADED=1

# Platform-specific PATH setup first; each fragment self-guards by OS.
#shellcheck disable=SC1090
[ -r ~/.files/osx/env.sh ] && . ~/.files/osx/env.sh
#shellcheck disable=SC1090
[ -r ~/.files/windows/env.sh ] && . ~/.files/windows/env.sh

# Cross-platform prepends AFTER the platform setup so these take precedence
# (e.g. mise-managed runtimes win over a Homebrew node).
[ -d "$HOME/.local/share/mise/shims" ] && PATH="$HOME/.local/share/mise/shims:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
export PATH

# Point gpg-agent at a terminal only when one actually exists, so this file is
# safe if ever sourced in an interactive context. In the no-tty Copilot context
# this is skipped and commit signing relies on the running agent's cache.
if _tty="$(tty 2>/dev/null)"; then
  export GPG_TTY="$_tty"
fi
unset _tty
