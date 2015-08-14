#!/bin/bash

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
	complete -o default -W "$( sed 's/[, ].*//' < ~/.ssh/known_hosts | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi

# completion of docker commands
if [[ "$(which docker)" ]]; then
    . ~/.dotfiles/docker/bash_completion.sh
fi

#completion of grunt commands
if [[ "$(which grunt)" ]]; then
    eval "$(grunt --completion=bash)"
fi

#completion of rake commands
if [[ "$(which rake)" ]]; then
    . ~/.dotfiles/ruby/rake-completion.sh
fi

. ~/.dotfiles/osx/completion.sh
