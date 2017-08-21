#!/bin/bash

echo "Installing dotfiles into current profile"
files=($(ls -af|awk '/^\./ && ! /\.$/'))
for f in $files
do
	if [ "$f" = ".git" ]
	then
		continue
	fi

	cp ./${f} ~/.

	if [ $? -ne 0 ]
	then
		echo "ERROR: failed to copy ${f} to ~/."
		exit 2
	fi
done

echo "dotfiles reset successfully"
cd

