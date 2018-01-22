#!/bin/bash

# In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
# variable pointing GPG to the gpg-agent socket. This little script, which must be sourced
# in your shell's init script (ie, .bash_profile, .zshrc, whatever), will either start
# gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    #shellcheck disable=SC1090
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    #shellcheck disable=SC1090
    eval $(gpg-agent --daemon ~/.gnupg/.gpg-agent-info)
fi
