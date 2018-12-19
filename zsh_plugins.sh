export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "robbyrussell/oh-my-zsh", use:"*.sh"

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/terraform", from:oh-my-zsh
zplug "themes/robbyrussell", from:oh-my-zsh

zplug "lukechilds/zsh-nvm"

zplug "nogizhopaboroda/multitran_cli", as:command, use:translate
zplug "k4rthik/git-cal", as:command
zplug "RobBollons/passbox", as:command, use:passbox

zplug "zdharma/history-search-multi-word", defer:1
zplug "zsh-users/zsh-syntax-highlighting", defer:2


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
#zplug load --verbose
zplug load
