#!/bin/sh

shellcheck bash/*.sh
shellcheck osx/*.sh
shellcheck ruby/*.sh
shellcheck setup/*.sh
shellcheck test/*.sh
shellcheck tmux/*.sh
shellcheck windows/*.sh

# disable shellcheck git/functions.sh
shellcheck git/outstanding.sh
