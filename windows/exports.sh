#!/bin/bash

# Windows-only stuff. Abort if not Windows.
[[ -n "$WINDIR" ]] || return 1

export MSYS="winsymlinks:nativestrict"
