require("conform").setup {
  formatters_by_ft = {
    css = { "prettier" },
    html = { "prettier" },
    json = { "biome" },
    jsonc = { "biome" },
    lua = { "stylua" },
    scss = { "prettier" },
    sh = { "shfmt" },
    toml = { "taplo" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2" },
    },
  },
}
