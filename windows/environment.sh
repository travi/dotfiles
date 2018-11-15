#!/bin/bash

# Windows-only stuff. Abort if not Windows.
[[ -n "$WINDIR" ]] || return 0

heading 'Configuring ConEmu'
link_file "$HOME/.files/windows/ConEmu.xml" "$HOME/AppData/Roaming/ConEmu.xml"

heading 'Configuring Root CA Certificates'
if [ -e "$HOME/certificates/ca-root/cacert.pem" ]; then
    info 'already configured'
else
    mkdir -p ~/certificates/ca-root
    if wget --output-document="$HOME/certificates/ca-root/cacert.pem" https://curl.haxx.se/ca/cacert.pem; then
        success 'successfully configured'
    else
        fail 'configuration failed'
    fi
fi
