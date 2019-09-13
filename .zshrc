HERE=`dirname "$0"`

BREW_WORKSPACE=${BREW_WORKSPACE:-'default'}
BREWFILE_PATH=$HERE/Brewfile.$BREW_WORKSPACE

source $HERE/zsh_plugins.sh

#general settings
export EDITOR='nvim'

#colorize man pages
export MANROFFOPT='-c'
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[5;30;43m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'


#zsh keybindings
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[r"     clear-screen


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

function dump-brew(){
  brew bundle dump --force --file=$BREWFILE_PATH --verbose
  echo "dumped in $BREWFILE_PATH"
}

function sg(){
  LINK="http://www.google.com/search?hl=en&q=$@"
  open $LINK
}

function whereami(){
  ip=$(curl http://ipinfo.io/ip)
  ipinfo=$(curl "http://ip-api.com/json/$ip?lang=en&fields=country,city,as,query" | jsn)
  echo $ipinfo
}


#aliases
alias pbr="git br"
alias cbr="pbr | tr -d '\n' | pbcopy; echo 'branch name copied to clipboard'"
alias pick-commit="git log --pretty=format:'%H %s' | pick | grep -o '^\S*' | tr -d '\n'"
alias pick-branch="git branch | pick | tr -d ' '"

alias jsn="python -mjson.tool"
alias jsnp="python -c \"import sys; jsonp=sys.stdin.read(); print(jsonp[ jsonp.index('(') + 1 : jsonp.rindex(')') ])\" | jsn"

alias serve="python -m SimpleHTTPServer"

alias show-workspace="echo $BREW_WORKSPACE"

alias sl="pmset sleepnow"
alias re-source="source ~/.zshrc"

alias cat="ccat --color='always'"

alias tt="translate -S"

alias sha256="openssl dgst -sha256"
