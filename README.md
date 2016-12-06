# Etelej's dotfiles 

## 0. Update packages, and get dotfiles
```bash
sudo apt-get update
git clone https://github.com/peteretelej/dotfiles.git 
cd dotfiles
```

## 1. Install `vim-nox`
Has Lua support required by neocomplete plugin:
```bash
sudo apt-get install vim-nox
```

## 2. Install `tmux` - terminal multiplexer
```bash
sudo apt-get install tmux
```

## 3. Install Exuberant ctags for the Tagbar
```bash
sudo apt-get install exuberant-ctags
```

## 4. Create required vim folders:
```bash
mkdir -p ~/.vim/colors 
# ignore swapfiles folder, .vimrc disables backups and swpfiles

```

## 4. Install Vundle
```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## 5. Reset current dotfiles: Copies dotfiles to `$HOME`
```bash
./resetfiles.sh
```

## 6. Install Vundle plugins
Launch vim `vim`, ignore initial launch errors.  Install plugins:
```
:PluginInstall
```

## 7. Install vim-go plugins:
Launch vim, run `:GoInstallBinaries` or `:GoUpdateBinaries`

- Note on go update remember to run `gocode close` to stop and restart gocode (e.g. on neocomplete errors)

## 8. Copy color schemes
```bash
cp ~/.vim/bundle/vim-colorschemes/colors/* ~/.vim/colors/
```

- Replace existing molokai with Go Optimized github.com/fatih/molokai
```bash
cd ~/.vim/colors && rm molokai.vim && \
wget https://raw.githubusercontent.com/fatih/molokai/master/colors/molokai.vim
```


### Optional 
1. Setup Node <see javascript guide>+install webpack, eslint, jslint
	- Nodejs from official website (curl .. |bash)
	- jshint (for js syntax)

