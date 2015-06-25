#!/bin/bash

if [[ $(uname) == $(Linux) ]]; then
    battery=$(upower -e | grep battery | head -1)
    upower -i "$battery" | grep percentage | awk '{print $2}'
else
    pmset -g batt | awk 'NR==2 { gsub(/;/,""); print $2 }'
fi
