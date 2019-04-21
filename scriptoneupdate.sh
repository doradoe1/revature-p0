#!/bin/bash

apt upgrade -y
brew update -y
brew upgrade node -y
brew upgrade git -y
brew upgrade az -y

echo 'Это сделано'
exit 0

