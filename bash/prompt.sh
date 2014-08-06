function prompt_git() {
  prompt_getcolors
  local status output flags
  status="$(git status 2>/dev/null)"

  [[ $? != 0 ]] && return;

  output="$(echo "$status" | awk '/# Initial commit/ {print "(init)"}')"

  [[ "$output" ]] || output="$(echo "$status" | awk '/# On branch/ {print $4}')"
  [[ "$output" ]] || output="$(git branch | perl -ne '/^\* (.*)/ && print $1')"

  flags="$(
    echo "$status" | awk 'BEGIN {r=""} \
      /^# Changes to be committed:$/        {r=r "+"}\
      /^# Changes not staged for commit:$/  {r=r "!"}\
      /^# Untracked files:$/                {r=r "?"}\
      END {print r}'
    )"

    if [[ "$flags" ]]; then
      output="$output$c1:$c0$flags"
    fi
      echo "$c1[$c0$output$c1]$c9"
}

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
