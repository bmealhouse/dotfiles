#!/bin/bash

#------------------
#
# DEFINE VARIABLES
#
#------------------

MAC_FONT_DIR="$HOME/Library/Fonts"
USER_FONT_DIR="$HOME/Documents/fonts"
ZSH_PLUGINS_DIR="$ZSH/custom/plugins"
ZSH_THEMES_DIR="$ZSH/custom/themes"

#---------------
#
# DEFINE EMOJIS
#
#---------------

FLEXED_BICEP="\xf0\x9f\x92\xaa"
HOORAY="\xf0\x9f\x8e\x89"
LOLLIPOP="\xf0\x9f\x8d\xad"
ROCKET="\xf0\x9f\x9a\x80"

#------------------
#
# DEFINE FUNCTIONS
#
#------------------

write_notification () {
  printf "\n$1 \e[1m $2\e[0m\n\n"
  # printf "\n\n$1 \e[1m $2\e[0m\n\n\n"
}

write_zshrc () {
  echo "$1" >> $HOME/.zshrc
}
