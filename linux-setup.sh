#!/bin/bash

##Automate the process of provisioning a new linux virtual machine.##
##Must include: up-to-date linux environment, brew, git, node, azure.##

##Advanced Packaging Tool##
sudo apt update
sudo apt upgrade -y
sudo apt-get install -y build-essential curl file git

#Install brew and git##
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>~/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
echo -ne '\n' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/m$

##Install gcc. GNU C compiler. Brew will manage it. The GNU Compiler Collection.##
##Compiles C into a script##
##Translate programing language to machine language.##
brew install gcc

##Install node.##
brew install node

##Install Azure.##
brew install azure-cli

echo 'You have a fully-functional and up-to-date Linux Environment'
