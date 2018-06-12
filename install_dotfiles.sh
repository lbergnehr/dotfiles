#!/bin/bash

set -e

dotfiles_location=~/dotfiles
dotfiles=(.vimrc .zshrc .gitconfig .vim)

main() {
  verify_git
  clone_repo
  backup_existing_dotfiles
  create_symlinks
}

verify_git() {
  if ! which git > /dev/null
  then
    >&2 echo 'Git is not installed'
    exit 1
  fi
}

clone_repo() {
  if ! test -d "$dotfiles_location"
  then
    git clone --recurse-submodules https://github.com/lbergnehr/dotfiles.git "$dotfiles_location"
  else
    (cd "$dotfiles_location" && git pull)
  fi
}

backup_existing_dotfiles() {
  for dotfile in "$dotfiles"
  do
    dotfile_path="$dotfiles_location/$dotfile"

    # Check for existing symlink
    if [[ "$(readlink ~/$dotfile)" == $dotfile_path ]]
    then
      continue
    fi

    # Check for other existing dotfile
    if test -e "~/$dotfile"
    then
      echo "Backing up ~/$dotfile to ~/${dotfile}.orig"
      mv "~/$dotfile" "${dotfile}.orig"
    fi
  done
}

create_symlinks() {
  for dotfile in "$dotfiles"
  do
    dotfile_path="$dotfiles_location/$dotfile"

    if ! test -e "~/$dotfile"
    then
      ln -s "$dotfile_path" "~/$dotfile"
    fi
  done
}

main $@
