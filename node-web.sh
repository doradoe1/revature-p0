#!/bin/bash

while read text
do
if [ -ne "{$text}" ]; then
	node index.js "${text}"
fi
done
exit 0

