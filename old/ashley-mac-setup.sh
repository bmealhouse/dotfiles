#!/bin/bash
set -e

#
# MANUAL CONFIGURATION
#
# System Preferences
#  * Displays > Display > Select "Scaled" & "More Space"
#  * Dock > Check "Automatically hide and show the Dock"
#  * Energy Saver > Set "Turn display off after:" to 15 min
#  * Printers & Scanners > Add HP ENVY 5530 series network printer
#  * Sharing > Edit Computer Name & Local Hostname
#  * Trackpad > Point & Click > Check "Tap to click"
#  * Trackpad > Scroll & Zoom > Uncheck "Scroll direction: Natural"
#
# Install Microsoft Office 365
#  * Download & install Microsoft Office 365 from https://portal.office.com
#

# Download & install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Setup Cask by tapping their repositories
brew tap caskroom/cask

# Download & install Adobe Creative Cloud
brew cask install adobe-creative-cloud
open -a "/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app"

# Download & install Adobe Reader
brew cask install adobe-reader

# Download & install Alfred
brew cask install alfred

# Download, install, & license SizeUp
brew cask install sizeup
# TOOO: license file removed from git repo
#open SizeUp.sizeuplicense

# Download & install Spotify
brew cask install spotify
