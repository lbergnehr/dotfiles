#!/bin/bash

# Install oh my zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Install Vundle (vim plugin manager)
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Selecta
git clone https://github.com/garybernhardt/selecta.git ~/bin/selecta_repo && ln -s ~/bin/selecta_repo/selecta ~/bin/selecta

# Clone the dotfiles and symlink them
git clone https://github.com/lbergnehr/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.hgrc ~/.hgrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
rm ~/.zshrc && ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.tmux.config ~/.tmux.conf
