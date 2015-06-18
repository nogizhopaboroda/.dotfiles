#functions

function pbr () { #prints current git branch
  br=`git branch | grep "*"`
  echo ${br/* /}
}


#aliases

alias cbr="pbr | pbcopy; echo 'branch name copied'"
