# .dotfiles
my dotfiles


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
