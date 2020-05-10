#!/usr/bin/env bash

DOTFILES=$(pwd)

ln -sh $DOTFILES/zshrc $HOME/.zshrc
ln -sh $DOTFILES/bash_aliases $HOME/.bash_aliases
ln -sh $DOTFILES/bash_functions $HOME/.bash_functions
ln -sh $DOTFILES/vim/ $HOME/.vim
ln -sh $DOTFILES/vimrc $HOME/.vimrc
ln -s $HOME/Documents/bin $HOME/bin
