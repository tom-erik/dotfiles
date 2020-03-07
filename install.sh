#!/usr/bin/env bash

DOTFILES=$HOME/Developer/dotfiles

ln -sh $DOTFILES/zshrc $HOME/.zshrc
ln -sh $DOTFILES/vim/ $HOME/.vim
ln -sh $DOTFILES/vimrc $HOME/.vimrc
ln -s $HOME/Documents/bin $HOME/bin
