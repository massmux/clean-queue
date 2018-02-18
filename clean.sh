#!/bin/bash

## finds senders which match string and clean from queue 
## require pfdel.pl command to be installed. works with postfix

TOCUT='gmail.com'

read -p "String to find and cut: " strtocut 

a=`postqueue -p | grep -A 2 $strtocut | awk -F" " '{if ($1) print $7}'` 
echo "Found:"
for i in $(echo $a | tr " " "\n"); do 
	echo $i
done

read -p "Remove from queue(y/n):" REPLY 

if [[ $REPLY =~ ^[Yy]$ ]]
then
	for i in $(echo $a | tr " " "\n"); do 
		/root/tools/pfdel.pl $i
	done
fi
