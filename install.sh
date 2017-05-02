#!/usr/bin/env bash

git submodule init
git submodule update

cd ~
ln -sh dotfiles/bash_profile .bash_profile
ln -sh dotfiles/bashrc .bashrc
# ln -sh dotfiles/bin bin
# ln -sh dotfiles/caprc .caprc
# ln -sh dotfiles/gemrc .gemrc
# ln -sh dotfiles/gitconfig .gitconfig
# ln -sh dotfiles/githelpers .githelpers
# ln -sh dotfiles/gitignore .gitignore
# ln -sh dotfiles/git-prompt .git-prompt
# ln -sh dotfiles/helpers helpers
# ln -sh dotfiles/hyperterm.js .hyperterm.js
# ln -sh dotfiles/irbrc .irbrc
# ln -sh dotfiles/siegerc .siegerc
# ln -sh dotfiles/tmux .tmux
# ln -sh .tmux/tmux.conf .tmux.conf
# ln -sh dotfiles/vim .vim
# ln -sh .vim/vimrc .vimrc
ln -sh projects/dotfiles/zshrc .zshrc
ln -sh projects/dotfiles/zshrc.env .zshrc.env
# ln -sh dotfiles/emacs.d .emacs.d
