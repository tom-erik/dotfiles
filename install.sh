#!/usr/bin/env bash

cd ~
DOTFILES=~/projects/dotfiles

ln -sh $DOTFILES/zshrc .zshrc
ln -sh $DOTFILES/plugins/ted/ted.plugin.zsh $ZSH_CUSTOM/plugins/ted/ted.plugin.zsh 
ln -sh $DOTFILES/vim .vim
ln -sh $DOTFILES/vimrc .vimrc