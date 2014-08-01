# Exit code of previous command.
function prompt_exitcode() {
#  prompt_getcolors
  [[ $1 != 0 ]] && echo " $c2$1$c9"
}

function prompt_command() {
  PS1="\n"
  # path: [user@host:path]
  PS1="$PS1$c1[$c0\u$c1@$c0\h$c1:$c0\w$c1]$c9"
  
  PS1="$PS1\n"
  # date: [HH:MM:SS]
  PS1="$PS1$c1[$c0$(date +"%H$c1:$c0%M$c1:$c0%S")$c1]$c9"
  # exit code: 127
  PS1="$PS1$(prompt_exitcode "$exit_code")"
  PS1="$PS1 \$ "
}

PROMPT_COMMAND="prompt_command"
