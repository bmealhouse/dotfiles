return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ensure_installed = {
        -- defaults
        "lua",
        "vim",
        "vimdoc",

        -- low-level
        -- "c",
        -- "go",

        -- web development
        -- "css",
        -- "html",
        -- "javascript",
        -- "jsdoc",
        -- "json",
        -- "jsonc",
        -- "prisma",
        -- "tsx",
        -- "typescript",

        -- other
        -- "bash",
        -- "diff",
        -- "gitignore",
        -- "markdown",
        -- "markdown_inline",
        -- "query",
        -- "regex",
        -- "toml",
        -- "yaml",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        -- default
        "lua-language-server",
        "stylua",

        -- low-level
        -- "gofumpt",
        -- "goimports-reviser",
        -- "golines",
        -- "gopls",

        -- web development
        -- "biome",
        -- "css-lsp",
        -- "eslint-lsp",
        -- "html-lsp",
        -- "json-lsp",
        -- "prettier",
        -- "prisma-language-server",
        -- "tailwindcss-language-server",
        -- "typescript-language-server",

        -- other
        -- "bash-language-server",
        -- "marksman",
        -- "shfmt",
        -- "taplo",
        -- "yaml-language-server",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      -- require "configs.lspconfig"
    end,
  },

  { -- Lightweight yet powerful formatter plugin for Neovim
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = function()
      require "configs.formatter"
    end,
  },

  { -- Neovim setup for init.lua and plugin development with full signature
    -- help, docs and completion for the nvim lua API
    "folke/neodev.nvim",
    opts = {},
  },

  { -- Library of 35+ independent Lua modules improving overall Neovim
    -- experience with minimal effort
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

  --   {
  --     "mfussenegger/nvim-lint",
  --     event = "VeryLazy",
  --     config = function()
  --       require "configs.lint"
  --     end,
  --   },
  --
  --   {
  --     -- https://github.com/olexsmir/gopher.nvim
  --     "olexsmir/gopher.nvim",
  --     ft = "go",
  --     config = function(_, opts)
  --       require("gopher").setup(opts)
  --       require("core.utils").load_mappings "gopher"
  --     end,
  --     build = function()
  --       vim.cmd [[silent! GoInstallDeps]]
  --     end,
  --   },
  --
  --   {
  --     "github/copilot.vim",
  --     event = "VeryLazy",
  --   },
  --
  --   {
  --     "nvim-tree/nvim-tree.lua",
  --     opts = {
  --       git = { enable = true },
  --     },
  --   },
}
