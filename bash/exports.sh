export CLICOLOR=1

. ~/.dotfiles/osx/exports.sh

# Make vim the default editor
export EDITOR="vim";

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

export LESS=-R
# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page
#export MANPAGER="less -X";
export MANPAGER="less";

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";

# Link Homebrew casks in `/Applications` rather than `~/Applications`
#export HOMEBREW_CASK_OPTS="--appdir=/Applications";

