#!/bin/sh

shellcheck ruby/*.sh

# shellcheck bash/*.sh
shellcheck bash/.bash_profile
shellcheck bash/.bashrc
shellcheck bash/256-colors.sh
shellcheck bash/colors.sh
shellcheck bash/colors_and_formatting.sh
# shellcheck bash/completion.sh
shellcheck bash/prompt.sh
# shellcheck bash/aliases.sh
shellcheck bash/exports.sh
shellcheck bash/source.sh

shellcheck setup/*.sh
