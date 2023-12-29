local plugins = {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "css",
        "gitignore",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "prisma",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "bash-language-server",
        "biome",
        "css-lsp",
        "eslint-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "prettier",
        "prisma-language-server",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "taplo",
        "typescript-language-server",
        "yaml-language-server",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
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
      require "custom.configs.formatter"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "custom.configs.lint"
    end,
  },
}

return plugins
