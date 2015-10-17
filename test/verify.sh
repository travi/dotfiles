#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

shellcheck -x bash/*.sh
shellcheck -x osx/*.sh
shellcheck -x ruby/*.sh
shellcheck -x setup/*.sh
shellcheck -x test/*.sh
shellcheck -x tmux/*.sh
shellcheck -x windows/*.sh

# disable shellcheck -x git/functions.sh
shellcheck -x git/outstanding.sh
