#!/usr/bin/env bash

DOTFILES=$(pwd)

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sh $DOTFILES/zshrc $HOME/.zshrc
ln -sh $DOTFILES/bash_aliases $HOME/.bash_aliases
ln -sh $DOTFILES/bash_functions $HOME/.bash_functions
ln -sh $DOTFILES/vimrc $HOME/.vimrc
ln -s $HOME/Documents/bin $HOME/bin

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

brew install fzf
brew install rg

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
