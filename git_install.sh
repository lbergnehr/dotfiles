#!/bin/sh
IFS=

user=`whoami`

install_file () {
  local dir=${1:?}
  local file=${2:?}

  # Copy any existing file
  local backedUpFile=${file}.`date "+%H_%M_%S"`.orig
  if ( mv "/Users/${user}/$file" "/Users/${user}/$backedUpFile" ); then
    echo Backed up old $file to $backedUpFile
  fi

  # Link the file from the repo to user dir
  echo Linking ${dir}/$file to /Users/${user}/$file
  ln -s "${dir}/$file" /Users/${user}/$file
}

echo Installing Leo\'s dotfiles through git and symbolic links for $user...

# Clone the repository to the user directory
echo Cloning dotfiles repository...
targetDir=${1:=/Users/leo/dotfiles}
if !( git clone git@github.com:lbergnehr/dotfiles.git $targetDir ); then
  echo Could not clone repository
  echo Aborting installation
  exit 1
fi

# Loop over all dotfiles
for f in .gitconfig .hgrc .vimrc .zshrc; do
  # There might be an empty string from that list...
  if [ "$f" = "" ]; then
    continue
  fi

  if ( install_file "$targetDir" "$f" ); then
    echo Installed $file successfully
  else
    echo Could not install $file
  fi
done

echo Installation complete
