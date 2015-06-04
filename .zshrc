#functions

function git_get_current_branch () {
  br=`git branch | grep "*"`
  echo ${br/* /}
}


#aliases

alias cbr="git_get_current_branch | pbcopy; echo 'branch name copied'"
