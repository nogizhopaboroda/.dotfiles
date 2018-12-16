cd $(mktemp -d) && curl https://raw.githubusercontent.com/nogizhopaboroda/.dotfiles/master/Brewfile.work > Brewfile && brew bundle install

chsh -s $(which zsh)
