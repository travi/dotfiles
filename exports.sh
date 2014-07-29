export CLICOLOR=1

export PATH=/usr/local/bin:$(brew --prefix ruby)/bin:$PATH
export M2_HOME=$(brew --prefix maven31)/libexec
export PYTHONPATH=$(brew --prefix mercurial)/lib/python2.7/site-packages:$(brew --prefix mercurial)/lib/python2.7/site-packages/mercurial:$PYTHONPATH

# Make vim the default editor
export EDITOR="vim";

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page
#export MANPAGER="less -X";
export MANPAGER="less";

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";

# Link Homebrew casks in `/Applications` rather than `~/Applications`
#export HOMEBREW_CASK_OPTS="--appdir=/Applications";

