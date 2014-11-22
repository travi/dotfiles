#!/bin/sh

bracket_color="\[${white}\]"
colon_color="\[${white}\]"

prompt_color="\[${green}\]"

if [[ "$SSH_TTY" ]]; then
  # connected via ssh
  prompt_color="\[${cyan}\]"
elif [[ "$USER" == "root" ]]; then
  # logged in as root
  prompt_color="\[${purple}\]"
fi

function prompt_git() {
  local status output flags

  status="$(git status 2>/dev/null)"

  [[ $? != 0 ]] && return;

  output="$(echo "$status" | awk '/Initial commit/ {print "(init)"}')"

  [[ "$output" ]] || output="$(echo "$status" | awk '/On branch/ {print $4}')"
  [[ "$output" ]] || output="$(git branch | perl -ne '/^\* (.*)/ && print $1')"

  flags="$(
    echo "$status" | awk 'BEGIN {r=""} \
      /^(# )?Changes to be committed:$/        {r=r "${green}+"}\
      /^(# )?Changes not staged for commit:$/  {r=r "${red}!"}\
      /^(# )?Untracked files:$/                {r=r "${orange}?"}\
      END {print r}'
  )"

  if [[ "$flags" ]]; then
    output="$output$colon_color:$prompt_color$flags"
  fi
  echo "$bracket_color[$yellow$output$bracket_color]${reset}"
}

function prompt_hg() {
  local summary output bookmark flags

  summary="$(hg summary 2>/dev/null)"

  [[ $? != 0 ]] && return;

  output="$(echo "$summary" | awk '/branch:/ {print $2}')"
  bookmark="$(echo "$summary" | awk '/bookmarks:/ {print $2}')"

  flags="$(
    echo "$summary" | awk 'BEGIN {r="";a=""} \
      /(modified)/     {r= "+"}\
      /(unknown)/      {a= "?"}\
      END {print r a}'
  )"

  #output="$output:$bookmark"
  if [[ "$flags" ]]; then
    output="$output$colon_color:$prompt_color$flags"
  fi
  echo "$bracket_color[$prompt_color$output$bracket_color]${reset}"
}

# Exit code of previous command.
function prompt_exitcode() {
  local exitcode_color="\[${red}\]"

  [[ $1 != 0 ]] && echo " $exitcode_color$1\[${reset}\]"
}

function prompt_command() {
  local exit_code=$?

  PS1="\n"
  # open new tabs at cwd on OSX
  if type update_terminal_cwd > /dev/null 2>&1; then
    PS1="$PS1$(update_terminal_cwd)"
  fi
  # git: [branch:flags]
  PS1="$PS1$(prompt_git)"
  # hg:  [branch:flags]
  PS1="$PS1$(prompt_hg)"
  # path: [user@host:path]
  PS1="$PS1$bracket_color[$prompt_color\u${white}@$prompt_color\h$colon_color:$prompt_color\w$bracket_color]${reset}"

  PS1="$PS1\n"
  # date: [HH:MM:SS]
  PS1="$PS1$bracket_color[$(date +"$prompt_color%H$colon_color:$prompt_color%M$colon_color:$prompt_color%S")$bracket_color]\[${reset}\]"
  # exit code: 127
  PS1="$PS1$(prompt_exitcode "$exit_code")"
  PS1="$PS1 \$ "
}

PROMPT_COMMAND="prompt_command"
