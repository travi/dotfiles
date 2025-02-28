#!/bin/bash

# Windows-only stuff. Abort if not Windows.
[[ -n "$WINDIR" ]] || return 0

. ~/.files/windows/ssh-agent.sh
