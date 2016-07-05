#!/bin/sh

# use sudo to check processes not owned by the current user
port_process() {
    if [ "$(which lsof)" ]; then
        lsof -i TCP:"$1" | grep LISTEN
    else
        netstat -aon | grep "LISTENING" | grep ":$1"
    fi
}

http(){
    curl "http://httpcode.info/$1";
}
