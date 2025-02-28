#!/bin/bash

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
	complete -o default -W "$( sed 's/[, ].*//' < ~/.ssh/known_hosts | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi

# completion of docker commands
if command -v docker > /dev/null 2>&1; then
    . ~/.files/docker/bash_completion.sh
fi

#completion of grunt commands
if command -v grunt > /dev/null 2>&1; then
    eval "$(grunt --completion=bash)"
fi

#completion of rake commands
if command -v rake > /dev/null 2>&1; then
    . ~/.files/ruby/rake-completion.sh
fi

#completion of npm commands
if command -v npm > /dev/null 2>&1; then
    source <(npm completion)
fi

. ~/.files/osx/completion.sh
