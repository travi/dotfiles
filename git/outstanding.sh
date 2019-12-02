#!/bin/bash

function outstanding() {
    while IFS= read -r -d '' dir
    do
        echo -n "."
        (
        cd "$dir" || exit
        local state;
        if [ -d ".git" ]; then
            status="$(git status 2>/dev/null)"
            changes="$(
              echo "$status" | awk 'BEGIN {r=""}
                /^(# )?Changes to be committed:$/        {r=r "staged "}
                /^(# )?Changes not staged for commit:$/  {r=r "modified "}
                /^(# )?Untracked files:$/                {r=r "untracked "}
                END {print r}'
            )"
            state=$state"${changes}"

            out="$(git out 2>/dev/null)"
            if [ -n "$out" ]; then
                state=$state"out "
            fi

            in="$(git in 2>/dev/null)"
            if [ -n "$in" ]; then
                state=$state"in "
            fi

            if [ -n "$state" ]; then
                echo -ne \\r"${BLUE}$dir${RESET} "
                echo "$state"
            fi
        fi
        )
    done <   <(find . -maxdepth 1 -mindepth 1 -type d -print0)
}
