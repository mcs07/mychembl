#!/bin/sh

echo "Installing Homebrew"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

echo "Updating Homebrew"
brew update

# Add homebrew taps for PHP, science and cheminformatics packages
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/science
brew tap homebrew/php
brew tap homebrew/apache
brew tap mcs07/cheminformatics

echo "Installing homebrew packages"
brew install git
brew install cmake
brew install wget
brew install python
brew install postgresql
brew install boost --with-python
brew install php55 --with-apache --with-pgsql
brew install rdkit --with-avalon --with-postgresql

# Install mod_wsgi - see https://github.com/Homebrew/homebrew-apache
sw_vers -productVersion | grep -E '^10\.[89]' > /dev/null && bash -c "[ -d /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain ] && sudo -u $(ls -ld /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain | awk '{print $3}') bash -c 'ln -vs XcodeDefault.xctoolchain /Applications/Xcode.app/Contents/Developer/Toolchains/OSX$(sw_vers -productVersion | cut -c-4).xctoolchain' || sudo bash -c 'mkdir -vp /Applications/Xcode.app/Contents/Developer/Toolchains/OSX$(sw_vers -productVersion | cut -c-4).xctoolchain/usr && ln -s /usr/bin /Applications/Xcode.app/Contents/Developer/Toolchains/OSX$(sw_vers -productVersion | cut -c-4).xctoolchain/usr/bin'"
brew install mod_wsgi
