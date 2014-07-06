# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mercurial brew cp node npm tmux)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=~/bin:~/.rbenv/shims:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export GIT_LOG_ALIAS=l

# Vim as editor
export EDITOR=vim

# Set vi key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# Fix to make git autocompletion usable
__git_files () {
  _wanted files expl 'local files' _files
}

bindkey '^h' history-incremental-search-backward

# Browsa widget to quickly switch folder
browsa() {
  cd $(find * -type d | egrep -v "^\.|/\." | selecta)
}
zle -N browsa
bindkey '^g' browsa

# Aliases
alias edit-git-conflicts='vim -O $(git st -s | grep ^UU | cut -c 4- | xargs)'
alias beautify-js-files='echo **/*.js | tr " " "\n" | grep -v "moment.js" | while read line; do js-beautify -s 2 -m 2 -r $line; done'
