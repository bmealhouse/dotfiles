require("lint").linters_by_ft = {
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

-- BufWritePost, InsertLeave, TextChanged
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    pcall(require, "lint.try_lint")
  end,
})
