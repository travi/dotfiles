#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

shellcheck --exclude=SC1091,SC1090 bash/*.sh
shellcheck osx/*.sh
shellcheck ruby/*.sh
shellcheck --exclude=SC1091 setup/*.sh
shellcheck test/*.sh
shellcheck tmux/*.sh
shellcheck windows/*.sh

# disable shellcheck git/functions.sh
shellcheck git/outstanding.sh
