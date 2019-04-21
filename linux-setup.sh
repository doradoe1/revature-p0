#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt-get install -y build-essential curl file git
echo -ne '\n' | sh -c -y "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>~/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
sudo apt install -y python3-distutils
brew install node
brew upgrade node
brew install gcc
brew install azure-cli

echo 'You have a fully-functional DEATH-STAR'

