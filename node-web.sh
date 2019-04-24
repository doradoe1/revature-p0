#!/bin/bash

##Automate the process of starting, and stopping a node web application.##
##Include: node, and 1 script with 2 functions.##

##Check for node. Cannot continue without node.##

if [ -z $(which node) ]; then
echo "Node missing. Install node. Run brew install node, then try again" 1>&2
exit 1
fi

##Variables.##
##Action value must be start or stop. Directory does not have restrictions.##

action=$1
directory=$2

##Validate and navigate to given directory.##

if ! [ -d $directory ]; then
echo "Invalid directory name. Please double check your input, and try again" 1>&2
exit 1
fi
cd $directory

##Check directory for package.json.##

if ! [ -e package.json ]; then
echo "Directory does not contain package.json" 1>&2
exit 1
fi

##Function one: Start.##

start()
{

##Check package.json for the start script.##

stsc=$(cat package.json | grep "start")
if [ -z "$stsc" ]; then
echo "p.json doesn't have a start script." 1>&2
exit 1
fi

##Start the project.##

echo "Starting Project."
npm start

}

##Function two: Stop.##

stop()
{

##check package.json for stop script##

stpsc=$(cat package.json | grep "stop")
if [ -z "$stpsc" ]; then
echo "p.json doesn't have a stop script." 1>&2
exit 1
fi

##Stop the project.##

echo "Stopping Project"
npm stop

}

##Run the given action.##

case "$action" in
"start")
start
;;
"stop")
stop
;;
esac
