#!/bin/bash

# Windows-only stuff. Abort if not Windows.
[[ -n "$WINDIR" ]] || return 0

#shellcheck disable=SC1090
. ~/.files/windows/ssh-agent.sh
