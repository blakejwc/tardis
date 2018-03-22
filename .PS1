FOREGROUND="\[\033[0m\]"

TERMINAL_TEXT="\[\033[38;5;11m\]"
PIPE_COLOR="\[\033[38;5;93m\]"
TIME_COLOR="\[\033[38;5;46m\]"
HAPPY_FACE="\[\033[38;5;46m\]"
SAD_FACE="\[\033[38;5;196m\]"
GIT_COLOR="\[\033[38;5;196m\]"
LINE_COLOR="\[\033[38;5;196m\]"

TOP_PIPE="$PIPE_COLOR\[\033(0\]l\[\033(B\]["
BOTTOM_PIPE="$PIPE_COLOR\[\033(0\]m\[\033(B\]["
CONNECTING_PIPE="$PIPE_COLOR]-["
END_PIPE="$PIPE_COLOR]"

function prompt_parse_git_branch {
  gitBranch=$(__git_ps1 "%s")
  if [ -z $gitBranch ]; then
    echo "gitless"
  else
    echo "$gitBranch"
  fi
}

TIME_24="$TIME_COLOR\t"
LINE_NMB="$LINE_COLOR\!"
USER_HOST="$TERMINAL_TEXT\u@\h"
SMILEY="\`if [ \$? = 0 ]; then echo '$HAPPY_FACE'^_^\[\e[0m\]; else echo '$SAD_FACE'O_O\[\e[0m\]; fi\`"
WKDIR="$TERMINAL_TEXT\w"
GIT_BRCH="$GIT_COLOR\$(prompt_parse_git_branch)"
PROMT_END=" $TERMINAL_TEXT\$ $FOREGROUND"

PS1="$TOP_PIPE$USER_HOST$CONNECTING_PIPE$TIME_24$CONNECTING_PIPE$LINE_NMB$CONNECTING_PIPE$SMILEY$END_PIPE\n$BOTTOM_PIPE$WKDIR$CONNECTING_PIPE$GIT_BRCH$END_PIPE$PROMT_END"
