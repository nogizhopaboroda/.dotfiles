gem install xcode-install

cd $(mktemp -d) && curl https://raw.githubusercontent.com/nogizhopaboroda/.dotfiles/master/Brewfile.work > Brewfile && brew bundle install

chsh -s $(which zsh)


#sudo defaults write com.apple.loginwindow LoginHook `pwd`/remap_keys.sh
