dotfiles
========

Collection of various config files.

* vim
* zsh
* macOS Terminal Profile files

Based on https://github.com/hukl/dotfiles. However, some parts of it have been completely overhauled.

## Vim

Link the vim dir into your homedir. Vim will recognise the `vimrc` file.

`~ $ ln -s dotfiles/vim .vim`

`~ $ mkdir .vimbackup`


## ZSH

Link the zsh dir into your homedir. The `.zshrc` file must be linked separately.

`~ $ ln -s dotfiles/zsh .zsh`

`~ $ ln -s dotfiles/zsh/zshrc .zshrc`
