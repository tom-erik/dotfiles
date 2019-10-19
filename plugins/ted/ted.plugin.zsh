# Aliases
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
alias did="mvim +'normal Go' +'r!date' ~/did.txt"
alias todo="mvim ~/Documents/todo.txt"

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
    zle redisplay
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"
