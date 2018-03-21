#!/bin/bash
source ./functions.sh

if [[ ! -d "~/.oh-my-zsh" ]] ; then
  write_notification $ROCKET "Installing: Oh My ZSH!"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
