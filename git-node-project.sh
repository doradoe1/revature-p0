#!/bin/bash

##Automate the process of setting up a new git project repository structure.##
##Include: verify req-1 is valid, and create web node-based project.##

##Check for dev environment (requirement one).##
##Do not allow it to continue if git or node are missing.##

if [ -z "which git" ]; then
echo "Git missing. Install git. Run brew install git, then try again." 1>&2
exit 1
fi

if [ -z "which node" ]; then
echo "Node missing. Install node. Run brew install node, then try again" 1>&2
exit 1
fi

echo "Environment verification complete."

# git::initial commit.##

##Variables needed for script.##
directory=$1
username=$2
email=$3

##Check if the given directory exists. If it doesn't, create it.##
if ! [ -d $directory ]; then
mkdir -p $directory
fi

cd $directory

##Validate the given directory. It must be empty or nonexistent.##
##Else try another directory.##
if [ -n "$(ls -A $directory)" ]; then
echo "Directory is not empty. Please choose another location or empty the directory." 1>&2
exit 1
fi
echo "Requirements verified. Creating git structure."

##Use this structure just like the sacred text foretold.##
##Docker.##
mkdir .docker

touch \
.docker/dockerfile \
.docker/dockerup.yaml

##Github.##
mkdir -p \
.github/ISSUE_TEMPLATE \
.github/PULL_REQUEST_TEMPLATE

touch \
.github/ISSUE_TEMPLATE/issue-template.md \
.github/PULL_REQUEST_TEMPLATE/pull-request-template.md \
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

echo "Это сделано"

##Initialize the Git repository conversion.##

echo "Initializing the git repository. Provide username and email."
git init
git config user.name $name
git config user.email $email

## Convert to Node project.##
echo "Creating Node Project"
npm init -y

echo "Process completed."
