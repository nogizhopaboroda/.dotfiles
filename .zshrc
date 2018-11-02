HERE=`dirname "$0"`


source $HERE/zsh_plugins.sh

#general settings
export EDITOR='vim'

bindkey "[D" backward-word
bindkey "[C" forward-word


#functions

#usage:
#git only-new | each rm
function each() {
  while read line; do
    for f in "$@"; do
      $f $line
    done
  done
}

function mkcd() {
  mkdir $1 && cd $1
}

function bcat(){
  bat "$1" --style=plain --paging=never
}


#aliases
alias pbr="git br"
alias cbr="pbr | tr -d '\n' | pbcopy; echo 'branch name copied to clipboard'"
alias pick-commit="git log --pretty=format:'%H %s' | pick | grep -o '^\S*' | tr -d '\n'"
alias pick-branch="git branch | pick | tr -d ' '"

alias jsn="python -mjson.tool"
alias jsnp="python -c \"import sys; jsonp=sys.stdin.read(); print(jsonp[ jsonp.index('(') + 1 : jsonp.rindex(')') ])\" | jsn"

alias serve="python -m SimpleHTTPServer"

alias dump-brew="brew bundle dump --force --file=~/.dotfiles/Brewfile --verbose && echo 'dumped in brew bundle dump --force --file=~/.dotfiles/Brewfile --verbose'"

alias sl="pmset sleepnow"
alias re-source="source ~/.zshrc"

alias cat="ccat --color='always'"

