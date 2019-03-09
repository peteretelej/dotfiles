# nvim config dir

Save as `~/.config/nvim`

## TODO
- install vim-plug

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

- install `ale`
```
mkdir -p ~/.local/share/nvim/site/pack/git-plugins/start
git clone https://github.com/w0rp/ale.git ~/.local/share/nvim/site/pack/git-plugins/start/ale
```

- install python 3.6+

- enable python3 on nvim
```
pip3 install --user pynvim
```

- Add init.vim file
```
cp -rf nvim ~/.config/.
```

- Run PlugClean & PlugInstall

