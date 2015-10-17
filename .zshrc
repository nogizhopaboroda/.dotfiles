#functions

function pbr () { #prints current git branch
  br=`git branch | grep "*"`
  echo ${br/* /}
}

function each() {
  while read line; do
    for f in "$@"; do
      $f $line
    done
  done
}

#aliases

alias cbr="pbr | tr -d '\n' | pbcopy; echo 'branch name copied'"
alias pick-commit="git log --pretty=format:'%H %s' | pick | grep -o '^\S*' | tr -d '\n'"
alias pick-branch="git branch | pick"
