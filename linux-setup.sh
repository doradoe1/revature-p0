#!/bin/bash

##Advanced Packaging Tool##
sudo apt update
sudo apt upgrade -y

#Install brew##
sudo apt-get install build-essential curl file git
echo -ne '\n' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>~/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)


##Install git.##
brew install git

##Install gcc.##
brew install gcc

##Install node.##
brew install node

##Install Azure.##
brew install azure-cli

##Updating the installed packages and tools.##
brew update
brew upgrade git
brew upgrade gcc
brew upgrade node
brew upgrade az

echo 'You have a fully-functional and up-to-date Linux Environment'
