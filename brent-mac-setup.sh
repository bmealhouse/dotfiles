#!/bin/bash
source ./functions.sh

#------------------
#
# DEFINE VARIABLES
#
#------------------

USER_NAME="Brent Mealhouse"
USER_EMAIL="bmealhouse@gmail.com"

#---------------
#
# CONFIGURE GIT
#
#---------------

# Configure git user name
if [[ "$(git config --global user.name)" != "$USER_NAME" ]] ; then
  write_notification $FLEXED_BICEP "Configuring: git user.name"
  git config --global user.name "$USER_NAME"
fi

# Configure git user email
if [[ "$(git config --global user.email)" != "$USER_EMAIL" ]] ; then
  write_notification $FLEXED_BICEP "Configuring: git user.email"
  git config --global user.email "$USER_EMAIL"
fi

#---------------
#
# CONFIGURE SSH
#
#---------------

# Create SSH Key
if [[ ! -s "$HOME/.ssh/id_rsa.pub" ]] ; then
  write_notification $LOLLIPOP "Creating: SSH Key"

  ssh-keygen -t rsa -b 4096 -C "$USER_EMAIL"
  MAC_SSH_KEY=$(cat $HOME/.ssh/id_rsa.pub)

  # TODO: removed github api token
  #curl -X POST \
  #  -H "Content-Type: application/json" \
  #  -H "Authorization: token $GITHUB_API_TOKEN" \
  #  -d "{\"title\":\"Brent's MacBook Pro VM\",\"key\":\"$MAC_SSH_KEY\"}" \
  #  https://api.github.com/user/keys
fi

# Configure SSH known_hosts
if [[ ! -s "$HOME/.ssh/known_hosts" ]] ; then
  write_notification $FLEXED_BICEP "Configuring: SSH known_hosts"
  # TODO: removed known_hosts
  # cp config/known_hosts $HOME/.ssh/known_hosts
fi

#--------------------------------
#
# INSTALL ESSENTIAL APPLICATIONS
#
#--------------------------------

# Install Homebrew & Cask
which -s brew
if [[ $? != 0 ]] ; then
  write_notification $ROCKET "Installing: Homebrew\n\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  write_notification $ROCKET "Installing: Cask"
  brew tap caskroom/cask
  brew tap caskroom/versions
fi

# Install Visual Studio Code Insiders
if [[ ! -d "$(echo /Applications/Visual\ Studio\ Code*.app)" ]] ; then
  write_notification $ROCKET "Installing: Visual Studio Code - Insiders"

  write_zshrc ""
  write_zshrc "# Visual Studio Code - Insiders"

  brew cask install visual-studio-code-insiders
  code-insiders --install-extension ms-vscode.atom-keybindings
  code-insiders --install-extension samverschueren.linter-xo
  code-indisers --install-extension whizkydee.material-palenight-theme
  code-insiders --install-extension esbenp.prettier-vscode
  code-insiders --install-extension blanu.vscode-styled-jsx
  code-insiders --install-extension be5invis.vscode-icontheme-nomo-dark
  cp config/vscode/ "$HOME/Library/Application Support/Code/User"

  write_zshrc "alias code=code-insiders"
fi

# Install Alfred
if [[ ! -d "$(echo /Applications/Alfred*.app)" ]] ; then
  write_notification $ROCKET "Installing: Alfred"
  brew cask install alfred

  # TODO: ensure this is working
  open -a "$(echo /Applications/Alfred*.app)"
fi

#-----------------
#
# INSTALL NODE.JS
#
#-----------------

# Install nvs (node version switcher)
if [[ ! -s "$HOME/.nvs/nvs.sh" ]] ; then
  write_notification $ROCKET "Installing: nvs"

  write_zshrc ""
  write_zshrc "# nvs"

  NVS_HOME="$HOME/.nvs"
  git clone https://github.com/jasongin/nvs "$NVS_HOME"
  . "$NVS_HOME/nvs.sh" install

  write_zshrc "nvs auto on"
fi

# Install Node.js
which -s node
if [[ $? != 0 ]] ; then
  write_notification $ROCKET "Installing: Node.js"
  nvs add latest
  nvs link latest
  nvs use

  # TODO: install global packages?
  # npm install -g now-redirect wt-cli
fi

# CONFIGURE NPM
#
# npm set init-author-name 'Brent Mealhouse'
# npm set init-author-email 'bmealhouse@gmail.com'
# # npm set init-author-url 'https://qubed.io'
# npm set init-license 'MIT'
# npm set save-exact true

# cat ~/.npmrc

# # login to npm for publishing
# # npm adduser


# Install yarn
which -s yarn
if [[ $? != 0 ]] ; then
  write_notification $ROCKET "Installing: yarn"
  brew install yarn

  # TODO: install global packages?
fi

#--------------------
#
# CONFIGURE TERMINAL
#
#--------------------

# Install Hyper
if [[ ! -d "/Applications/Hyper.app" ]] ; then
  write_notification $ROCKET "Installing: Hyper"
  brew cask install hyper
  cp config/hyper.js $HOME/.hyper.js
fi

# # Install Pure
# if [[ ! -s "$ZSH_THEMES_DIR/pure.zsh-theme" ]] ; then
#   write_notification $ROCKET "Installing: Pure"
#   npm install --global pure-prompt
#   mkdir -p $ZSH_THEMES_DIR
#   cp $NVS_HOME/default/lib/node_modules/pure-prompt/pure.zsh $ZSH_THEMES_DIR/pure.zsh-theme
#   cp $NVS_HOME/default/lib/node_modules/pure-prompt/async.zsh $ZSH_THEMES_DIR/async.zsh
#   sed -E -i ".bak" 's/ZSH_THEME="[a-z]+"/ZSH_THEME="pure"/g' $HOME/.zshrc
# fi

# Install spot
which -s spot
if [[ $? != 0 ]] ; then
  write_notification $ROCKET "Installing: spot"

  SPOT_PATH="/usr/local/bin/spot"
  curl -L https://raw.github.com/rauchg/spot/master/spot.sh -o $SPOT_PATH
  chmod +x $SPOT_PATH
fi

# Install trash-cli
which -s trash
if [[ $? != 0 ]] ; then
  write_notification $ROCKET "Installing: trash-cli"

  write_zshrc ""
  write_zshrc "# trash-cli"
  npm install --global trash-cli

  write_zshrc "alias rm=trash"
fi

# Install zsh-autosuggestions
if [[ ! -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]] ; then
  write_notification $ROCKET "Installing: zsh-autosuggestions"

  # mkdir -p $ZSH_PLUGINS_DIR/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_PLUGINS_DIR/zsh-autosuggestions

  # TODO: add to .zshrc plugins
  # sed -E -i ".bak" 's/^plugins=\((.*)\)$/plugins=\(\1 zsh-autosuggestions\)/g' $HOME/.zshrc
fi

# Install zsh-syntax-highlighting
if [[ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]] ; then
  write_notification $ROCKET "Installing: zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGINS_DIR/zsh-syntax-highlighting

  # TODO: add to .zshrc plugins
  # sed -E -i ".bak" 's/^plugins=\((.*)\)$/plugins=\(\1 zsh-syntax-highlighting\)/g' $HOME/.zshrc
fi

# Create mac-icons alias
if [[ -z "$(grep "alias mac-icons" $HOME/.zshrc)" ]] ; then
  write_notification $LOLLIPOP "Creating: mac-icons alias"

  write_zshrc ""
  write_zshrc "# mac-icons"
  write_zshrc 'alias mac-icons="open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources"'
fi

# Create hillcitymnag secrets
# if [[ -z "$(grep "export HCAG_ZEIT_TOKEN" $HOME/.zshrc)" ]] ; then
#   write_notification $LOLLIPOP "Creating: hillcitymnag secrets"
#
#   REMOVED SECRETS
# fi

#---------------
#
# INSTALL FONTS
#
#---------------

mkdir -p $USER_FONT_DIR

# Install codeface
if [[ ! -d "$USER_FONT_DIR/codeface" ]] ; then
  write_notification $ROCKET "Installing: codeface"
  git clone https://github.com/chrissimpkins/codeface.git $USER_FONT_DIR/codeface
  find_command="find \"$USER_FONT_DIR/codeface\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"
  eval $find_command | xargs -0 -I % cp "%" "$MAC_FONT_DIR/"
fi

# # Install Operator Mono
# if [[ ! -d "$USER_FONT_DIR/operator-mono" ]] ; then
#   write_notification $ROCKET "Installing: Operator Mono"
#   mkdir -pv $USER_FONT_DIR
#   cp -R -v fonts/operator-mono $USER_FONT_DIR/operator-mono
#   cp -R $USER_FONT_DIR/operator-mono/OpenType/ $MAC_FONT_DIR
# fi

# Install powerline-fonts
if [[ ! -d "$USER_FONT_DIR/powerline-fonts" ]] ; then
  write_notification $ROCKET "Installing: powerline-fonts"
  git clone https://github.com/powerline/fonts.git $USER_FONT_DIR/powerline-fonts
  $USER_FONT_DIR/powerline-fonts/install.sh
fi

# ---

# Configure npm
# npm config set init-author-name "$USER_NAME"
# npm config set init-author-email "$USER_EMAIL"
# # npm config set init-author-url "https://qubed.io"
# npm config set init-license "MIT"
# npm config set save-exact true
# npm completion >> $HOME/.zshrc
# echo "alias npmlsg=\"npm ls -g --depth 0\"" >> $HOME/.zshrc

#-----------------------------------------
#
# INSTALL APPLICATIONS THAT REQUIRE INPUT
#
#-----------------------------------------

# Install Adobe Acrobat Reader
if [[ ! -d "/Applications/Adobe Acrobat Reader DC.app" ]] ; then
  write_notification $ROCKET "Installing: Adobe Acrobat Reader"
  brew cask install adobe-acrobat-reader
fi

# Install Adobe Creative Cloud
if [[ ! -d "/Applications/Adobe Creative Cloud" ]] ; then
  write_notification $ROCKET "Installing: Adobe Creative Cloud"
  brew cask install adobe-creative-cloud
  open -Wa "/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app"
fi

# Install Battle.net
if [[ ! -d "/Applications/Battle.net.app" ]] ; then
  write_notification $ROCKET "Installing: Battle.net"
  brew cask install battle-net
  open -Wa "/usr/local/Caskroom/battle-net/latest/Battle.net.app"
fi

# Install Docker
if [[ ! -d "/Applications/Docker.app" ]] ; then
  write_notification $ROCKET "Installing: Docker"
  brew cask install docker
  open -a "/Applications/Docker.app"
fi

# Install Now
if [[ ! -d "/Applications/Now.app" ]] ; then
  write_notification $ROCKET "Installing: Now"
  brew cask install now
  open -a "/Applications/Now.app"
fi

# brew cask install rocket
# Open app and add to accessiblity

# Install SizeUp
if [[ ! -d "/Applications/SizeUp.app" ]] ; then
  write_notification $ROCKET "Installing: SizeUp"
  brew cask install sizeup
  # TODO: license file removed from git repo
  # open -a "/Applications/SizeUp.app" licenses/SizeUp.sizeuplicense
fi

# Install SkyFonts
if [[ ! -d "/Applications/SkyFonts" ]] ; then
  write_notification $ROCKET "Installing: SkyFonts"
  brew cask install skyfonts
  open -Wa "$(echo /usr/local/Caskroom/skyfonts/*/SkyFonts.app)"
fi

# Install VirtualBox
if [[ ! -d "/Applications/VirtualBox.app" ]] ; then
  write_notification $ROCKET "Installing: VirtualBox"
  brew cask install virtualbox
fi

#----------------------
#
# INSTALL APPLICATIONS
#
#----------------------

# # Install other software
# brew install diff-so-fancy
# brew install mongodb
# brew install rethinkdb
# brew install tree
# brew install youtube-dl
# brew cask install appcleaner
# brew cask install doxie
# brew cask install firefox-developer-edition
# brew cask install google-chrome
# brew cask install google-chrome-canary
# brew cask install jadengeller-helium
# brew cask install libreoffice
# brew cask install macdown
# brew cask install mongodb-compass
# brew cask install ngrok
# brew cask install postman
# brew cask install quickbooks-online
# brew cask install rocket
# brew cask install slack
# brew cask install spotify
# brew cask install steam
# brew cask install the-unarchiver

# #
# # CONFIGURE TERMINAL
# #

# speed up mac backups
# sudo sysctl debug.lowpri_throttle_enabled=0
# add as an alias

# Fantastical 2
# TODO: automate mac app store installation
# https://github.com/mas-cli/mas

# Things
# TODO: automate mac app store installation
# https://github.com/mas-cli/mas

#-----------------------
#
# CONFIGURE ENVIRONMENT
#
#-----------------------

# Create ~/dev
mkdir -p $HOME/dev

# Clone Hill City Assembly of God repositories
HCAG_REPOS="hillcitymnag/hcag-deploy-webtask \
hillcitymnag/contact.hillcitymnag.church \
hillcitymnag/deploy.hillcitymnag.church \
hillcitymnag/events.hillcitymnag.church \
hillcitymnag/sermons.hillcitymnag.church \
hillcitymnag/www.hillcitymnag.church"

for HCAG_REPO in $HCAG_REPOS ; do
  if [[ ! -d "$HOME/dev/$HCAG_REPO" ]] ; then
    write_notification $ROCKET "Cloning: $HCAG_REPO"
    git clone git@github.com:$HCAG_REPO.git $HOME/dev/$HCAG_REPO
  fi
done

# Clone npm repositories
NPM_REPOS='micro-rollbar next-redux-saga'

for NPM_REPO in $NPM_REPOS ; do
  if [[ ! -d "$HOME/dev/npm/$NPM_REPO" ]] ; then
    write_notification $ROCKET "Cloning: npm/$NPM_REPO"
    git clone git@github.com:bmealhouse/$NPM_REPO.git $HOME/dev/npm/$NPM_REPO
  fi
done

# Clone todo repositories
TODO_REPOS='docs'

for TODO_REPO in $TODO_REPOS ; do
  if [[ ! -d "$HOME/dev/todo/$TODO_REPO" ]] ; then
    write_notification $ROCKET "Cloning: todo/$TODO_REPO"
    git clone git@github.com:bmealhouse/$TODO_REPO.git $HOME/dev/todo/$TODO_REPO
  fi
done

# Write completed message
write_notification $HOORAY "Done!"

#----------------------------------------------------------------------------
#
# MANUAL CONFIGURATION
#
#----------------------------------------------------------------------------
#
# System Preferences
#  * Displays > Display > Select "Scaled" & "More Space"
#  * Dock > Check "Automatically hide and show the Dock"
#  * Energy Saver > Set "Turn display off after:" to 15 min
#  * General > Check "Use dark menu bar and Dock"
#  * Keyboard > Customize Control Strip... > Replace Siri with Show Desktop
#  * Printers & Scanners > Add HP ENVY 5530 series network printer
#  * Sharing > Edit Computer Name & Local Hostname
#  * Trackpad > Scroll & Zoom > Uncheck "Scroll direction: Natural"
#
# Finder Preferences
#  * Advanced > Check "Keep folders on top when sorting by name"
#
# Install Microsoft Office 365
#  * Download & install Microsoft Office 365 from https://portal.office.com
#
#----------------------------------------------------------------------------



#----------------------------------------------------------------------------
#
# DOCUMENTATION
#
#----------------------------------------------------------------------------
#
# SED - STREAM EDITOR
#
# Example:
#  sed -E -i '.bak' 's/original/new/g' file.txt
#
# Explanation:
#  * sed = Stream EDitor
#  * -E = interpret regular expressions as extended (modern) regular expressions
#  * -i = in-place (i.e. save back to the original file)
#  * '.bak' = the extension to use for a backup
#  * The command string:
#     * s = the substitute command
#     * original = a regular expression describing the work to replace
#     * new = the text to replace it with
#     * g = global (i.e. replace all and not just the first occurrence)
#  * file.txt = the file name
#
#----------------------------------------------------------------------------
#
# FIND EMOJI HEXDUMP
#
# printf "\xf0\x9f\x9a\x80"
# printf 🚀 | hexdump
#
#----------------------------------------------------------------------------
