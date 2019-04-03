# go home
cd ~

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#curl brewfile
#brew bundle install
cd $(mktemp -d) && curl https://raw.githubusercontent.com/nogizhopaboroda/.dotfiles/master/Brewfile.default > Brewfile && brew bundle install

# clone repo
git clone https://github.com/nogizhopaboroda/.dotfiles.git ~/.dotfiles

# make zsh default shell
chsh -s $(which zsh)

# add custom .zshrc
cat <<EOT >> ~/.zshrc
if [ -f ~/.dotfiles/.zshrc ]; then
  source ~/.dotfiles/.zshrc
fi
EOT

# add custom .gitignore
cat <<EOT >> ~/.gitconfig
[include]
    path = ~/.dotfiles/.gitconfig
EOT

# add custom .vimrc
cat <<EOT >> ~/.vimrc
if filereadable(glob("~/.dotfiles/.vimrc"))
   source ~/.dotfiles/.vimrc
endif
EOT

# add custom kitty config
cat <<EOT >> ~/.config/kitty/kitty.conf
if filereadable(glob("~/.dotfiles/kitty.conf"))
   include ~/.dotfiles/kitty.conf
endif
EOT

# add cron jobs
crontab ~/.dotfiles/crontab.autoload

# install neobundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

# install neovim client
pip install neovim

# gem install xcode-install

# AFTER INSTALL

# install node
#nvm install node

#vim

#sudo defaults write com.apple.loginwindow LoginHook `pwd`/remap_keys.sh
