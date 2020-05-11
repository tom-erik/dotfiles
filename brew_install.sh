brew install fzf
brew install dos2unix
brew install freedts
brew install git
brew install hub
brew install imagemagick
brew install eq

brew install ripgrep
brew install the_silver_searcher
brew install wget
brew install autoenv

brew install pyenv
brew install mssql-tools

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
autoload -U compinit && compinit

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

