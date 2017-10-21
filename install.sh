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
	git\
	curl \
	vim-nox \
	tmux \
	exuberant-ctags

if [ $? -ne 0 ]
then
	echo "ERROR: failed to sudo update & install stuff."
	exit 2
fi

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# create directory for colors
mkdir -p ~/.vim/colors 

# install powerline fonts
git clone https://github.com/powerline/fonts.git && cd fonts && \
	./install.sh && cd .. && rm -rf fonts


# install vundle
rm -rf ~/.vim/bundle/Vundle.vim 
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

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

# install vim plugins
vim -c 'PluginInstall' -c 'qa!'


# copy colorschemes to correct directory
cp ~/.vim/bundle/vim-colorschemes/colors/* ~/.vim/colors/  

# get preferred molokai
cd ~/.vim/colors && rm molokai.vim && \                                       
wget https://raw.githubusercontent.com/fatih/molokai/master/colors/molokai.vim


if [ "$INSTALLTYPE" != "full" ]
then
	echo "Simple install.sh done."
	exit 0
fi

go version 2>&1 1>/dev/null
if [ $? -gt 0 ] 
then
	echo "Go not installed, skipping GoInstallBinaries"
else
	vim -c 'GoInstallBinaries' -c 'qa!'
fi


echo "Full install.sh done."

