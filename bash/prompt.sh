bracket_color="\[${white}\]"
colon_color="\[${white}\]"

prompt_color="\[${green}\]"

function prompt_git() {
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
      output="$output$colon_color:$prompt_color$flags"
    fi
      echo "$bracket_color[$prompt_color$output$bracket_color]$c9"
}

# Exit code of previous command.
function prompt_exitcode() {
  local exitcode_color="\[${red}\]"

  [[ $1 != 0 ]] && echo " $exitcode_color$1\[${reset}\]"
}

function prompt_command() {
  local exit_code=$?

  PS1="\n"
  # git: [branch:flags]
  PS1="$PS1$(prompt_git)"
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
