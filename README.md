# Etelej's dotfiles 


# Initial Setup
```
sudo apt-get update
sudo apt-get install -y \
	git \
	curl \
	vim-nox \
	tmux 
```

# Get dotfiles
```bash
git clone https://github.com/peteretelej/dotfiles.git 
cd dotfiles
```

## Install Exuberant ctags for the Tagbar
```bash
sudo apt-get install exuberant-ctags
```

## Create required vim folders:
```bash
mkdir -p ~/.vim/colors 
# ignore swapfiles folder, .vimrc disables backups and swpfiles

```

## Install Vundle
```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Reset current dotfiles: Copies dotfiles to `$HOME`
```bash
./resetfiles.sh
```

## Install Vundle plugins
Launch vim `vim`, ignore initial launch errors.  Install plugins:
```
:PluginInstall
```

## Install vim-go plugins:
Launch vim, run `:GoInstallBinaries` or `:GoUpdateBinaries`

- Note on go update remember to run `gocode close` to stop and restart gocode (e.g. on neocomplete errors)

## Copy color schemes
```bash
cp ~/.vim/bundle/vim-colorschemes/colors/* ~/.vim/colors/
```

- Replace existing molokai with Go Optimized github.com/fatih/molokai
```bash
cd ~/.vim/colors && rm molokai.vim && \
wget https://raw.githubusercontent.com/fatih/molokai/master/colors/molokai.vim
```


# OPTIONAL CONFIGS 

## Setup Nodejs
<see javascript guide> +install webpack, eslint, jslint

   - Nodejs from official website (curl .. |bash)
   - jshint (for js syntax)

## Install powerline fonts
```
# clone
git clone https://github.com/powerline/fonts.git
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
```

## Setup zsh
```
sudo apt-get install zsh

# setup oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# also changes default shell ie chsh -s $(which zsh)
```
