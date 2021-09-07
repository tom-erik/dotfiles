# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="dracula"
#ZSH_THEME="agnoster"
#ZSH_THEME="pygmalion"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

HISTCONTROL=ignoredups:ignorespace

typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root cursor)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!.git/*"'

# If you have installed hub using Homebrew, its completions may not be
# on your $FPATH if you are using the system zsh
# See https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/github
if (( ! ${fpath[(I)/usr/local/share/zsh/site-functions]} )); then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

# NVM config
export NVM_LAZY=1
export NVM_AUTOLOAD=1

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( direnv git github z history fzf docker zsh-syntax-highlighting )

source $ZSH/oh-my-zsh.sh

# User configuration
export PROJECT_HOME=$HOME/Developer
export GITHUB_USER=tom-erik@safeconsult.no
export DEFAULT_USER=tom-erik

# prevent sharing shell history between different windows (enabled by default in OMZ)
unsetopt SHARE_HISTORY
# unset INC_APPEND_HISTORY

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export MAILDIR=~/mail
export VAGRANT_DEFAULT_PROVIDER=vmware_desktop

if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

autoload -U compinit && compinit -C
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# test -e "${HOME}/bin/gruvbox_256palette.sh" && source "${HOME}/bin/gruvbox_256palette.sh"

# Created by `userpath` on 2020-12-18 21:44:00
export PATH="$PATH:$HOME/.local/bin"

setopt PROMPT_SUBST

# Required for direnv
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1

# BUGFIX: something sets extendedglob
unsetopt extendedglob

##### ALIASES
alias f="find . -name"

# get current ip and isp
alias gip="curl ipinfo.io/ip && curl ipinfo.io/org"

# sort by size
alias s="du -hs * | sort -rh"

 # Search your history for something, with colorized output
alias hs="history | grep"

# List SafeConsult repos
alias repos="hub api 'orgs/SafeConsult/repos?per_page=100' --paginate -t | awk '/\.full_name\\t/ {print $2}'"

# Sort by modification time - show what I left off
alias left='ls -t -1'

# Create a Python virtual environment
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

# Cat with syntax highlightinh
alias ccat='pygmentize -O style=monokai -f console256 -g'

alias v=$EDITOR
# mutt
alias m='neomutt'
# alias for syncing everything
alias O="cd ~ && mbsync -a && mu index"

# other often used stuff, mostly node/npm
alias ns="npm start"
alias nb="npm run build"
alias npmre='rm -f package-lock.json && rm -rf node_modules && npm install'


## FUNCTIONS
function pretty_tsv {
    perl -pe 's/((?<=\t)|(?<=^))\t/ \t/g;' "$@" | column -t -s $'\t' | less  -F -S -X -K
}

function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then 
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -F
}

function zombie() {
   ps aux | awk '{if ($8=="Z") { print $2 }}'
}

function npmls() {
   npm ls --depth=0 "$@" 2>/dev/null
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
