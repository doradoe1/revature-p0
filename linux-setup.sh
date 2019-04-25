#!/bin/bash

##Automate the process of provisioning a new linux virtual machine.##
##Must include: up-to-date linux environment, brew, git, node, azure.##

##Advanced Packaging Tool##
sudo apt update
sudo apt upgrade -y
sudo apt-get install -y build-essential curl file git

#Install brew, git, and configure the home path##
echo '' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

##Install gcc. GNU C compiler. Brew will manage it. The GNU Compiler Collection.##
##Compiles C into a script##
##Translate programing language to machine language.##
brew install gcc

##Install node.##
brew install node

##Install Azure.##
brew install azure-cli

echo 'You have a fully-functional and up-to-date Linux Environment'

echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>~/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
echo 'brew added to home path"
