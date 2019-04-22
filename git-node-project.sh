#!/bin/bash

##check for dev environment (requirement one).##
## Do not allow it to continue if one of them is missing.##

if [ -z "which brew" ]; then
  echo "Brew missing. Install brew. Run ./linux-setup.sh" 1>&2
  exit 1
fi

if [ -z "which git" ]; then
  echo "Git missing. Install git. Run ./linux-setup.sh" 1>&2
  exit 1
fi

if [ -z "which gcc" ]; then
  echo "GCC missing. Install gcc. Run ./linux-setup.sh" 1>&2
  exit 1
fi

if [ -z "which node" ]; then
  echo "Node missing. Install and upgrade node. Run ./linux-setup.sh" 1>&2
  exit 1
fi

if [ -z "which az" ]; then
  echo "Azure missing. Install azure. Run ./linux-setup.sh" 1>&2
  exit 1
fi

##Assing pwd a variable, otherwise the git repository will recognize pwd##
##as part of its structure, not the present working directory value.##
##This will allow is to create the git structure.##

# git::initial commit.##

currentdirectory=$1

if [ -z $currentdirectory ]; then
  currentdirectory=$(pwd)
fi

echo $currentdirectory
mkdir -p $currentdirectory/git-project
cd $currentdirectory/git-project
git init

## node.##
npm init -y

## Use this structure just like the sacred text foretold.##
## docker.##
mkdir .docker

touch \
  .docker/dockerfile \
  .docker/dockerup.yaml

## github.##
mkdir -p \
  .github/ISSUE_TEMPLATE \
  .github/PULL_REQUEST_TEMPLATE

touch \
  .github/ISSUE_TEMPLATE/issue-template.md \
  .github/PULL_REQUEST_TEMPLATE/pull-request-template.md

touch \
  .github/CODE-OF-CONDUCT.md \
  .github/CONTRIBUTING.md

mkdir \
  client \
  src \
  test

touch \
  client/.gitkeep \
  src/.gitkeep \
  test/.gitkeep

touch \
  .azureup.yaml \
  .dockerignore \
  .editorconfig \
  .gitignore \
  .markdownlint.yaml \
  CHANGELOG.md \
  LICENSE.txt \
  README.md

echo 'Это сделано'
exit 0
