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
