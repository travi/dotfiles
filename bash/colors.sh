#!/bin/bash

if [[ "${COLORTERM-}" = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
elif [[ $TERM = cygwin ]]; then
    :
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

export CLICOLOR=1

alias colortest='( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )'

if tput setaf 1 &> /dev/null && [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    tput sgr0; # reset colors
    BOLD=$(tput bold);
    RESET=$(tput sgr0);
    # Solarized colors, taken from http://git.io/solarized-colors.
    BLACK=$(tput setaf 0);
    BLUE=$(tput setaf 33);
    CYAN=$(tput setaf 37);
    GREEN=$(tput setaf 64);
    ORANGE=$(tput setaf 166);
    PURPLE=$(tput setaf 125);
    RED=$(tput setaf 124);
    VIOLET=$(tput setaf 61);
    WHITE=$(tput setaf 15);
    YELLOW=$(tput setaf 11);
    MAGENTA=$(tput setaf 125);
else
    BOLD='';
    RESET="\\033[0m";
    BLACK="\\033[1;30m";
    BLUE="\\033[1;34m";
    CYAN="\\033[1;36m";
    GREEN="\\033[0;32m";
    ORANGE="\\033[0;2;33m";
    PURPLE="\\033[1;35m";
    RED="\\033[1;31m";
    VIOLET="\\033[1;35m";
    WHITE="\\033[1;37m";
    YELLOW="\\033[1;33m";
    MAGENTA="\\033[1;31m";
fi;

export BOLD
export RESET
export BLACK
export BLUE
export CYAN
export GREEN
export ORANGE
export PURPLE
export RED
export VIOLET
export WHITE
export YELLOW
export MAGENTA

# BSD (including OSX)
export LSCOLORS=ExFxCxDxBxegedabagacad
# GNU
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Syntax-highlight in less
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=-R
# Highlight section titles in manual pages
export LESS_TERMCAP_md="${YELLOW}";

if grep --color "a" <<< "a" &> /dev/null; then
# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";
fi

# aliases for GRC from homebrew
if grc &>/dev/null && brew --version &>/dev/null; then
    #shellcheck disable=SC1091
    source "/usr/local/etc/grc.bashrc"
fi
