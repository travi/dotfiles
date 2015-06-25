#!/bin/sh

shellcheck ruby/*.sh
shellcheck setup/*.sh
shellcheck test/*.sh
shellcheck tmux/*.sh
shellcheck windows/*.sh

# disable shellcheck bash/*.sh
shellcheck bash/.bash_profile
shellcheck bash/.bashrc
shellcheck bash/256-colors.sh
shellcheck bash/colors.sh
shellcheck bash/colors_and_formatting.sh
# disable shellcheck bash/completion.sh
shellcheck bash/prompt.sh
# disable shellcheck bash/aliases.sh
shellcheck bash/exports.sh
shellcheck bash/source.sh

# disable shellcheck git/*.sh
shellcheck git/outstanding.sh

# disable shellcheck osx/*.sh
shellcheck osx/aliases.sh
shellcheck osx/completion.sh
# disable shellcheck osx/environment.sh
# disable shellcheck osx/exports.sh
shellcheck osx/software.sh
shellcheck osx/source.sh
