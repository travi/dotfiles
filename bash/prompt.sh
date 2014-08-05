# Exit code of previous command.
function prompt_exitcode() {
#  prompt_getcolors
  [[ $1 != 0 ]] && echo " \[${red}\]$1\[${reset}\]"
}

function prompt_command() {
  local exit_code=$?

  local prompt_color="\[${green}\]"
  local bracket_color="\[${white}\]"

  PS1="\n"
  # path: [user@host:path]
  PS1="$PS1$bracket_color[$prompt_color\u${white}@$prompt_color\h${white}:$prompt_color\w$bracket_color]${reset}"

  PS1="$PS1\n"
  # date: [HH:MM:SS]
  PS1="$PS1$bracket_color[$(date +"$prompt_color%H\[${white}\]:$prompt_color%M\[${white}\]:$prompt_color%S")$bracket_color]\[${reset}\]"
  # exit code: 127
  PS1="$PS1$(prompt_exitcode "$exit_code")"
  PS1="$PS1 \$ "
}

PROMPT_COMMAND="prompt_command"
