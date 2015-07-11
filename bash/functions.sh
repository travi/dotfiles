#!/bin/sh

# use sudo to check processes not owned by the current user
port-process() {
    lsof -i TCP:"$1" | grep LISTEN
}
