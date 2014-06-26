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