#!/bin/bash

if [ $(id -u) -eq 0 ]
then
	echo "ERROR: ./install.sh should not be run as root"
	exit 2
fi

if [ "${PWD##*/}" != "dotfiles" ]
then
	echo "ERROR: ./install.sh must be run from dotfiles directory"
	exit 2
fi

INSTALLTYPE="simple"
if [ "$1" != "--full" ] && [ "$1" != "-full" ]
then
	echo "Running simple dotfiles install. use './install.sh --full' for full install if needed"
else
	INSTALLTYPE="full"
	echo "Running FULL install.sh"
fi

sudo apt-get update && \
	sudo apt-get install -y \
	build-essential \
	git \
	curl \
	vim-nox \
	tmux \
	exuberant-ctags \
	silversearcher-ag 

if [ $? -ne 0 ]
then
	echo "ERROR: failed to sudo update & install stuff."
	exit 2
fi

# Install npm
which npm 2>&1 >/dev/null
if [ $? -gt 0 ]
then
curl -0 -L https://npmjs.org/install.sh | sudo sh
fi 

# set global npm
mkdir $HOME/npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
# install yarn
npm install -g yarn 2>&1 >/dev/null



echo "installing dotfiles into user profile"
files=($(ls -af|awk '/^\./ && ! /\.$/ && ! /\.git/'))
for f in ${files[@]}
do
	cp ./${f} ~/.

	if [ $? -ne 0 ]
	then
		echo "ERROR: failed to copy ${f} to ~/."
		exit 2
	fi
done


echo "Install done."
