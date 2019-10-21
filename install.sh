#!/usr/bin/env bash

cd ~
DOTFILES=~/Developer/dotfiles

ln -sh $DOTFILES/zshrc .zshrc
if [[ -z $ZSH_CUSTOM/plugins/ted ]]; then
   ln -sh $DOTFILES/plugins/ted $ZSH_CUSTOM/plugins/ted
fi
ln -sh $DOTFILES/vim/ .vim
ln -sh $DOTFILES/vimrc .vimrc
