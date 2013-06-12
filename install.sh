#!/bin/sh
IFS=

echo Installing Leo\'s dotfiles for `whoami`...

urlRoot = https://raw.github.com/lbergnehr/dotfiles/master/



for f in .gitconfig .hgrc .vimrc .zshrc do
  if [ install_file $f ]; then
    echo Installed $file successfully
  else
    echo Could not install $file
  fi
done

echo Installation complete

function install_file () {
  file = $1

  # Copy any existing file
  mv $file ${file}.orig

  curl ${urlRoot}${file} > ~/$file
}
