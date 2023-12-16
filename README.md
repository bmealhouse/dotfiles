# dotfiles

## Alacritty

```sh
cd ~/.config
ln -s ~/dev/dotfiles/alacritty alacritty
```

## zsh

```sh
cd ~
ln -s ~/dev/dotfiles/zsh/.zshrc .zshrc
```

## Neovim

```sh
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
cd ~/.config/nvim/lua
ln -s ~/dev/dotfiles/nvim/lua/custom custom
```
