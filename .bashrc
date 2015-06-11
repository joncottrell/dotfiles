# Make a git-aware prompt
function git-branch-name {
local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
  fi

    echo $branch
}

function git-dirty {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    echo '*'
  fi
}

function gitify {
    status=$(git status 2>/dev/null | tail -n 1)
    if [[ $status == "" ]]
    then
        echo ""
    else
        echo $(git-branch-name)$(git-dirty)
    fi
}

function make-prompt {
  local RED="\[\033[0;31m\]"
  local GREEN="\[\033[0;32m\]"
  local LIGHT_GRAY="\[\033[0;37m\]"
  local BLUE="\[\033[0;34m\]"
 
PS1="$BLUE[$RED\$(date +%H:%M)$BLUE]\
$BLUE[${GREEN}\w$BLUE]\
$BLUE[${RED}\$(gitify)$BLUE]\
${GREEN} >\
${LIGHT_GRAY} \n"
}

make-prompt

# Load aliases
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
