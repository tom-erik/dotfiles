#!/usr/bin/env bash
# shamelessly taken from https://github.com/PezCoder/dotfiles/blob/master/install.sh

set -euo pipefail

command_exists () {
  type "$1" &> /dev/null ;
}

errm () {
    2>&1 echo -e "$@"
}

installed () {
  echo -e " ✓ $1 already installed."
}

confirm_no_clobber() {
    NOTADOT=''

    for i in ${DOTS[@]}; do
        dst=.$i
        if [ ! -L $dst -a -e $dst ]; then
            NOTADOT="${NOTADOT}$dst "
        fi
    done

    if [ -n "$NOTADOT" ]; then
        errm "\n  ABORT"
        errm "\n  These exist but are not symlinks:"
        errm "    $NOTADOT"
        exit 2
    fi
}

install_plug() {
  if [ ! -f ".vim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    installed 'Plug'
  fi
}

install_tmux () {
  if !(command_exists tmux); then
    brew install tmux
  else
    installed 'tmux'
  fi
}

install_tmux_clipboard() {
  if !(command_exists reattach-to-user-namespace); then
    brew install reattach-to-user-namespace
  fi
}

install_neovim() {
  if !(command_exists nvim); then
    brew install neovim/neovim/neovim
    pip3 install --user pynvim
  else
    installed 'neovim'
  fi
}

link_dot() {
    src=$1
    dst=.$1
    rm -f "$dst"
    ln -s "$EXPORT_DIR/$src" "$dst"
}

main() {
  cd $HOME
  confirm_no_clobber

  install_plug
  install_tmux
  install_tmux_clipboard
  install_neovim

  for i in ${DOTS[@]}; do
      link_dot $i
  done

  if [ ! -d "$HOME/bin" ]; then
    ln -s "$HOME/Documents/bin" "$HOME/bin"
  fi

  if [ ! -d "$HOME/.vim/spell" ]; then
    mkdir "$HOME/.vim/spell"
    cp $EXPORT_DIR/spellfiles/* "$HOME/.vim/spell/"
    rm -f "$HOME/.vim/custom-dictionary.utf-8.add*"
    ln -s "$EXPORT_DIR/custom-dictionary.utf-8.add" "$HOME/.vim/custom-dictionary.utf-8.add*"
    touch "$HOME/.vim-local-dictionary.utf-8.add"
  fi

  git config --global core.excludesfile ~/.gitignore_global
}

# Initialize globals
EXPORT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
DOTS=(
  zshrc
  vimrc
  tmux.conf
  gitignore_global
)

# Run install
main
