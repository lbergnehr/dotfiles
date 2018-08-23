# Fix for using autojump
unsetopt BG_NICE

# Fix for wsl
umask 022

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
plugins=(git mercurial brew cp node npm tmux tmuxinator autojump ruby rake gem)

source $ZSH/oh-my-zsh.sh
source $HOME/dotfiles/tmuxinator.zsh

# Customize to your needs...
export PATH=~/bin:~/.rbenv/shims:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export GIT_LOG_ALIAS=l
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!.hg/*"'

# Vim as editor
export EDITOR=vim

# Set vi key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd v edit-command-line 

export GPG_TTY=$(tty)

# Fix to make git autocompletion usable
__git_files () {
  _wanted files expl 'local files' _files
}

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward

# set up for insert mode too
bindkey -M viins '^P' history-incremental-pattern-search-backward
bindkey -M viins '^N' history-incremental-pattern-search-forward

# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol

# Key bindings

insert-git-status-file-in-command-line() {
  file=$(((git status --porcelain | fzf --ansi -m) || return) | awk '{ print $2 }')
  LBUFFER="$LBUFFER$file"
  zle reset-prompt
}
zle -N insert-git-status-file-in-command-line

insert-git-branch-in-command-line() {
  branch=$(git branch --color=always --all | sed 's/^[\* ]*//' | fzf --ansi)
  LBUFFER="$LBUFFER$branch"
  zle reset-prompt
}
zle -N insert-git-branch-in-command-line

insert-git-revision-in-command-line() {
  revision=$((git lf --all | fzf --ansi --reverse --preview "echo {} | cut -d ' ' -f 1 | tr -d '\042' | xargs git show --format=fuller --color" || return) | awk '{ print $1 }')
  LBUFFER="$LBUFFER$revision"
  zle reset-prompt
}
zle -N insert-git-revision-in-command-line

insert-file-in-command-line() {
  cat_command='cat'
  if which bat > /dev/null; then
    cat_command='bat --color always'
  fi

  file=$(fzf -m --ansi --preview "file {} && $cat_command {}" || return)
  LBUFFER="$LBUFFER$file"
  zle reset-prompt
}
zle -N insert-file-in-command-line

bindkey "^g^s" insert-git-status-file-in-command-line
bindkey "^g^b" insert-git-branch-in-command-line
bindkey "^g^r" insert-git-revision-in-command-line
bindkey "^f"   insert-file-in-command-line

# Aliases
alias bt='wget http://cachefly.cachefly.net/100mb.test -O /dev/null'

# Nicer colors for ls
if [ -f ~/.dir_colors ] && which -s dircolors > /dev/null; then
  eval $(dircolors ~/.dir_colors)
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


