# dotfiles
Just browse the dotfiles themselves for nice configs, otherwise you can install them using the procedure below:

1. Get the dotfiles
```bash
git clone https://github.com/peteretelej/dotfiles.git 
cd dotfiles                                           
```
2. Run dotfiles installation script
```bash
./install.sh --full
```
- `--full` installs required OS tools (e.g. vim, tmux, htop etc.) and dotfiles.
- You can omit the `--full` flag to only install the dotfiles.

Disclaimer: 

> I no longer actively use vim so the vim configs here have been reset to sensible defaults, and all plugins removed.