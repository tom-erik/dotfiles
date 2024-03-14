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

export REPOS="$HOME/Developer"
export DOTFILES="$REPOS/dotfiles"
export SECOND_BRAIN="$HOME/Documents/Garden/Para"
export SCRIPTS="$HOME/bin"

if command -v brew > /dev/null; then
   fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit
compinit 

export PATH="$PATH:$HOME/bin"
export EDITOR='nvim'

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
alias ll="exa -alh"
alias la="exa --all --long --group-directories-first --header"
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



autoload -Uz bashcompinit && bashcompinit
# autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# eval "$(register-python-argcomplete pipx)"
[[ -f ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh

source "$DOTFILES/plugins/alias-tips/alias-tips.plugin.zsh"

eval "$(direnv hook zsh)"
# eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(thefuck --alias)"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
