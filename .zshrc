#functions

function pbr () { #prints current git branch
  br=`git branch | grep "*"`
  echo ${br/* /}
}


#aliases

alias cbr="pbr | tr -d '\n' | pbcopy; echo 'branch name copied'"
