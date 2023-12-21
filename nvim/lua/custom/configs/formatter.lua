require("conform").setup {
  formatters_by_ft = {
    html = { "prettier" },
    lua = { "stylua" },
    sh = { "shfmt" },
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
