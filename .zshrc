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
export PATH=~/bin:~/.local/bin:~/.rbenv/shims:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export GIT_LOG_ALIAS=l
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*' --glob '!.hg/*'"

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

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

_gs() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
  --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

_f() {
  cat_command='cat'
  if which bat > /dev/null; then
    cat_command='bat --color always'
  fi

  eval "$FZF_DEFAULT_COMMAND" | fzf-down --multi --ansi --preview "file {} && $cat_command {}"
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-helper() {
  local c
  for c in $@; do
    eval "fzf-$prefix$c-widget() { local result=\$(_$prefix$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-$prefix$c-widget"
    eval "bindkey '${prefix:+^$prefix}^$c' fzf-$prefix$c-widget"
  done
}

prefix=g bind-helper s b t r h
bind-helper f
unset -f bind-helper

# Aliases
alias bt='wget http://cachefly.cachefly.net/100mb.test -O /dev/null'

# Nicer colors for ls
if [ -f ~/.dir_colors ] && which -s dircolors > /dev/null; then
  eval $(dircolors ~/.dir_colors)
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


