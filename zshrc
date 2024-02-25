export HISTFILE="$HOME/.zsh_history"
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTTIMEFORMAT="[%F %T] "

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS

export EDITOR='nvim'

source $HOME/Developer/oss/zsh-autocomplete/zsh-autocomplete.plugin.zsh

if command -v brew > /dev/null; then
   fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit
# compinit is disabled because of zsh-autocomplete
# compinit 

export PATH="$PATH:$HOME/bin"

# directories
export REPOS="$HOME/Developer"

alias vim="nvim"
alias v="nvim"

# git
alias g="git"
alias gst="g status"
alias gd="git diff"
alias gl="g pull"
alias gp="g push"
alias gc="g commit --verbose"
alias gapa="g add --patch"
alias prc="gh pr create -w"
alias glo="g log --oneline --graph --all"

# ls
alias ls="exa --icons"
alias ll="exa -alh"
alias la="exa --all --long --group-directories-first --header"
alias tree="exa --tree"

alias cat="bat"
alias t="tmux"

# cd
alias repos="cd $REPOS"
alias dot="cd $REPOS/dotfiles"

# editing
alias ez='v ~/.zshrc'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sz='source ~/.zshrc'


autoload -Uz bashcompinit && bashcompinit
# autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# eval "$(register-python-argcomplete pipx)"
[[ -f ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh
eval "$(direnv hook zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(thefuck --alias)"
