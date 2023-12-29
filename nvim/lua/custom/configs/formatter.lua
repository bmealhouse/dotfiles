require("conform").setup {
  formatters_by_ft = {
    css = { "prettier" },
    html = { "prettier" },
    json = { "biome" },
    jsonc = { "biome" },
    lua = { "stylua" },
    markdown = { "prettier" },
    scss = { "prettier" },
    sh = { "shfmt" },
    toml = { "taplo" },
    yaml = { "prettier" },
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
