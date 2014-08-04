# Exit code of previous command.
function prompt_exitcode() {
#  prompt_getcolors
  [[ $1 != 0 ]] && echo " ${red}$1${reset}"
}

function prompt_command() {
  local exit_code=$?

  PS1="\n"
  # path: [user@host:path]
  PS1="$PS1${white}[${blue}\u${white}@${blue}\h${white}:${blue}\w${white}]${reset}"

  PS1="$PS1\n"
  # date: [HH:MM:SS]
  PS1="$PS1${white}[${blue}$(date +"%H${white}:${blue}%M${white}:${blue}%S")${white}]${reset}"
  # exit code: 127
  PS1="$PS1$(prompt_exitcode "$exit_code")"
  PS1="$PS1 \$ "
}

PROMPT_COMMAND="prompt_command"
