local options = {
  formatters_by_ft = {
    css = { "prettierd" },
    html = { "prettierd" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    lua = { "stylua" },
    markdown = { "prettierd" },
    toml = { "taplo" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    yaml = { "prettierd" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
