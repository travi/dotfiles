#!/bin/bash

shopt -s expand_aliases
. ../bash/aliases.sh

choice=${1:-}

if [[ -z $choice ]]; then
    heading "Which setup step(s) would you like to perform?"
    echo -e "\t1: Environment Configuration"
    echo -e "\t2: Software Installation/Update"
    echo -e "\t3: Both"

    echo -en "\nPlease enter your choice: "
    read -r choice
fi

if [[ ${choice} -eq 0 ]]; then
    info "Aborting"
elif [[ ${choice} -eq 1 ]]; then
    . ./environment.sh
elif [[ ${choice} -eq 2 ]]; then
    . ./software.sh
elif [[ ${choice} -eq 3 ]]; then
    . ./environment.sh
    . ./software.sh
else
    fail "Your choice of '${choice}' is invalid"
fi
