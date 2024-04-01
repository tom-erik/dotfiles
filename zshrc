# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
export HISTFILE="$HOME/.zsh_history"
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTTIMEFORMAT="[%F %T] "

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

##### BINDINGS
# bindkey "^R" history-incremental-search-backward
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
bindkey "\eF"  forward-word
bindkey "\eB"  backward-word

export EDITOR='nvim'
export PATH="$PATH:$HOME/bin"

export REPOS="$HOME/Developer"
export DOTFILES="$REPOS/dotfiles"
export SECOND_BRAIN="$HOME/Documents/Garden/Para"
export SCRIPTS="$HOME/bin"

if command -v brew > /dev/null; then
   fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit
compinit 

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
alias lg="lazygit"

# ls
alias ls="exa --icons"
alias ll="exa --long --header"
alias la="exa --all --long --header"
alias tree="exa --tree"

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias cat="bat"
alias t="tmux"
alias p="pnpm"

# cd
alias repos="cd $REPOS"
alias dot="cd $DOTFILES"
alias garden="cd $HOME/Documents/Garden"
alias para="cd $SECOND_BRAIN"
alias scripts="cd $SCRIPTS"

alias traktor="cd $REPOS/traktortakst"
alias api="cd $REPOS/traktortakst_api"
alias dev="cd $REPOS/traktordev"
alias bfp="cd $REPOS/bilforlaget-bfpublish"
alias cara="cd $REPOS/carweb-caranalyze"

# editing
alias ez='v ~/.zshrc'
alias sz='source ~/.zshrc'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias et='v todo.md'
alias er='v README.md'

# vim & second brain
alias sb="cd \$SECOND_BRAIN"
alias in="cd \$SECOND_BRAIN/0\ Inbox/"

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'


autoload -Uz bashcompinit && bashcompinit
# autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source "$DOTFILES/plugins/alias-tips/alias-tips.plugin.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(thefuck --alias)"
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
