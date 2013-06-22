#!/bin/sh
IFS=

user=`whoami`

install_file () {
  local dir=${1:?}
  local file=${2:?}

  # Copy any existing file
  oldFile=/Users/${user}/$file
  local backedUpFile=${file}.`date "+%H_%M_%S"`.orig
  if ( mv "${oldFile}" "/Users/${user}/$backedUpFile" ); then
    echo Backed up old \"${oldFile}\" to \"${backedUpFile}\"
  fi

  # Link the file from the repo to user dir
  sourceFile="${dir}/${file}"
  newFile=$oldFile
  echo Linking ${dir}/$file to $newFile
  ln -s "${sourceFile}" $newFile
}

echo Installing Leo\'s dotfiles through git and symbolic links for ${user}...

# Clone the repository to the user directory
echo Cloning dotfiles repository...
targetDir=dotfiles
targetPath=`pwd`/$targetDir
if !( git clone git@github.com:lbergnehr/${targetDir}.git ); then
  echo Could not clone repository
  echo Aborting installation
  exit 1
fi

# Install all dotfiles
for f in .gitconfig .hgrc .vimrc .zshrc .tmux.conf; do
  # There might be an empty string from that list...
  if [ "$f" = "" ]; then
    continue
  fi

  if ( install_file "$targetPath" "$f" ); then
    echo Installed $file successfully
  else
    echo Could not install $file
  fi
done

# Install misc files and folders

# Install vundle into ~/.vim/bundle
vundleTargetPath=/Users/${user}/.vim/bundle/vundle
if [ ! -d "$vundleTargetPath" ]; then
  ln -s "$targetPath/.vim/bundle/vundle" ~/.vim/bundle/vundle
fi

echo Installation complete
