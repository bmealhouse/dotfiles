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
        "c",
        "go",

        -- web development
        "css",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "prisma",
        "tsx",
        "typescript",

        -- other
        "bash",
        "diff",
        "gitignore",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "toml",
        "yaml",
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
        "gofumpt",
        "goimports-reviser",
        "golines",
        "gopls",

        -- web development
        "biome",
        "css-lsp",
        "eslint-lsp",
        "html-lsp",
        "json-lsp",
        "prettier",
        "prisma-language-server",
        "tailwindcss-language-server",
        "typescript-language-server",

        -- other
        "bash-language-server",
        "marksman",
        "shfmt",
        "taplo",
        "yaml-language-server",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
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

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },

  {
    -- https://github.com/olexsmir/gopher.nvim
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

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "github/copilot.vim",
    event = "VeryLazy",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
    },
  },
}
