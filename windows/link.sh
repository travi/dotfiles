# Cross-platform symlink function. With one parameter, it will check
# whether the parameter is a symlink. With two parameters, it will create
# a symlink to a file or directory, with syntax: link $linkname $target
link() {
    local link_target=$2
    local link_name=$1

    # if link_target not provided
    if [[ -z ${link_target} ]]; then
        # Link-checking mode.
        if windows; then
            fsutil reparsepoint query ${link_name} > /dev/null
        else
            [[ -h ${link_name} ]]
        fi
    else
        # Link-creation mode.
        if windows; then
            # Windows needs to be told if it's a directory or not. Infer that.
            # Also: note that we convert `/` to `\`. In this case it's necessary.
            if [[ -d ${link_target} ]]; then
                cmd <<< "mklink /D \"$1\" \"${2//\//\\}\"" > /dev/null
            else
                cmd <<< "mklink \"$1\" \"${2//\//\\}\"" > /dev/null
            fi
        else
            # You know what? I think ln's parameters are backwards.
            ln -s ${link_target} ${link_name}
        fi
    fi
}
