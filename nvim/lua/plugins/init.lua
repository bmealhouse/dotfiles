return {

  -- nvim-treesitter is a simple and easy way to use the tree-sitter interface
  -- in Neovim and to provide some basic highlighting functionality based on it.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "gitignore",
        "go",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",

        -- work-specific
        "prisma",
      },
    },
  },

  -- nvim-lspconfig is a "data only" repo, providing basic, default Nvim LSP
  -- client configurations for various LSP servers.
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Lightweight yet powerful formatter plugin for Neovim.
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    event = "BufWritePre",
    opts = require "configs.conform",
    -- init = function()
    --   vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    -- end,
  },

  -- An asynchronous linter plugin for Neovim complementary to the built-in
  -- Language Server Protocol support.
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },

  -- lazydev.nvim is a plugin that properly configures LuaLS for editing your
  -- Neovim config by lazily updating your workspace libraries.
  {
    "folke/lazydev.nvim",
    ft = "lua",
  },

  -- Library of 35+ independent Lua modules improving overall Neovim
  -- experience with minimal effort.
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()
    end,
  },

  -- Minimalistic plugin for Go development in Neovim written in Lua.
  -- It's NOT an LSP tool, the main goal of this plugin is to add go tooling support in Neovim.
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings "gopher"
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}
