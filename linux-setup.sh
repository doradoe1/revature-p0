#!/bin/bash

apt update
apt-get install -y build-essential curl file git
echo -ne '\n' | sh -c -y "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>~/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew install git
brew install node
brew install azure-cli

echo 'You have a fully-functional DEATH-STAR'

apt upgrade -y
brew upgrade git
brew update
brew upgrade node
brew upgrade az

echo 'You have a fully-functional and up-to-date DEATH-STAR'
