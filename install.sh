#!/bin/sh
IFS=

install_file () {
  local file=$1

  # Copy any existing file
  mv $file ${file}.orig

  curl ${urlRoot}${file} > ~/$file
}

echo Installing Leo\'s dotfiles for `whoami`...

urlRoot=https://raw.github.com/lbergnehr/dotfiles/master/

for f in .gitconfig .hgrc .vimrc .zshrc; do
  # There might an empty string from that list...
  if [ "$f" = "" ]; then
    continue
  fi

  if ( install_file "$f" ); then
    echo Installed $file successfully
  else
    echo Could not install $file
  fi
done

echo Installation complete
