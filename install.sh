#!/usr/bin/env bash

set -e

EXPORT_DIR=$(dirname "$0")
DOTS=(
  zshrc
  vimrc
  gitignore_global
)

command_exists () {
  type "$1" &> /dev/null ;
}

link_dot() {
    src=$1
    dst=.$1
    rm -f $dst
    ln -s $EXPORT_DIR/$src $dst
}

cd $HOME

if [ ! -f ".vim/autoload/plug.vim" ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

for i in ${DOTS[@]}; do
    link_dot $i
done

if [ ! -d "$HOME/bin" ]; then
  ln -s $HOME/Documents/bin $HOME/bin
fi

git config --global core.excludesfile ~/.gitignore_global
