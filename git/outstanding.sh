#!/bin/bash

function outstanding() {
    while IFS= read -r -d '' dir
    do
        echo -n "."
        (
        cd "$dir" || exit
        local status;
        if [ -d ".git" ]; then
            out=$status"$(git out 2>/dev/null)"
            if [ ! -z "$out" ]; then
                status=$status" out"
            fi

            in=$status"$(git in 2>/dev/null)"
            if [ ! -z "$in" ]; then
                status=$status" in"
            fi

            if [ ! -z "$status" ]; then
                echo -ne \\r"${blue}$dir${reset}"
                echo "$status"
            fi
        fi
        )
    done <   <(find . -maxdepth 1 -mindepth 1 -type d -print0)
}
