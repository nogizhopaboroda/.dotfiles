# .dotfiles
my dotfiles


How to import `.zshrc`
--------------------------

Add to your `~/.zshrc`:
```
if [ -f ~/.dotfiles/.zshrc ]; then
  source ~/.dotfiles/.zshrc
fi
```

How to import `.gitconfig`
--------------------------

Add to your `~/.gitconfig`:
```
[include]
    path = ~/.dotfiles/.gitconfig
```


How to import `.vimrc`
--------------------------

Add to your `~/.vimrc`:
```
if filereadable(glob("~/.dotfiles/.vimrc"))
   source ~/.dotfiles/.vimrc
endif
```
