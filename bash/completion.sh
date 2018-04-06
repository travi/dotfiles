#!/bin/bash

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
	complete -o default -W "$( sed 's/[, ].*//' < ~/.ssh/known_hosts | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi

# completion of docker commands
if which docker > /dev/null 2>&1; then
    #shellcheck disable=SC1090
    . ~/.files/docker/bash_completion.sh
fi

#completion of grunt commands
if which grunt > /dev/null 2>&1; then
    eval "$(grunt --completion=bash)"
fi

#completion of rake commands
if which rake > /dev/null 2>&1; then
    #shellcheck disable=SC1090
    . ~/.files/ruby/rake-completion.sh
fi

#completion of npm commands
if which npm > /dev/null 2>&1; then
    #shellcheck disable=SC1090
    source <(npm completion)
fi

#shellcheck disable=SC1090
. ~/.files/osx/completion.sh
