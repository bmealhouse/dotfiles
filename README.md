# dotfiles

## Install

Requires [GNU Stow](https://www.gnu.org/software/stow/).

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` symlinks all packages into `$HOME` via `stow .`, then runs one-time
provisioning steps (e.g. global git aliases via `scripts/provision-git-aliases.sh`).

## Neovim

`nvim` is excluded from stow (see `.stow-local-ignore`) since it depends on NvChad:

```sh
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
cd ~/.config
ln -s ~/dotfiles/nvim nvim
```

### Research

- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [flash.nvim](https://github.com/folke/flash.nvim)
- [illuminate.vim](https://github.com/RRethy/vim-illuminate)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [lspkind.nvim](https://github.com/onsails/lspkind.nvim)
- [lspsaga.nvim](https://nvimdev.github.io/lspsaga/)
- [mini.ai](https://github.com/echasnovski/mini.ai)
- [mini.bufremove](https://github.com/echasnovski/mini.bufremove)
- [mini.comment](https://github.com/echasnovski/mini.comment)
- [mini.indentscope](https://github.com/echasnovski/mini.indentscope)
- [mini.pairs](https://github.com/echasnovski/mini.pairs)
- [mini.surround](https://github.com/echasnovski/mini.surround)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [notice.nvim](https://github.com/folke/noice.nvim)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre)
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [persistence.nvim](https://github.com/folke/persistence.nvim)
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
