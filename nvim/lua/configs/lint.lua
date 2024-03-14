require("lint").linters_by_ft = {
  javascript = { "eslint" },
  javascriptreact = { "eslint" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
}

-- BufWritePost, InsertLeave, TextChanged
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
