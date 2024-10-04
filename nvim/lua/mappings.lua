require "nvchad.mappings"

-- Basic keymaps
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode.
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- gitsigns
vim.keymap.set("n", "<leader>sb", function()
  require("gitsigns").stage_buffer()
end, { desc = "Stage buffer" })

vim.keymap.set("n", "<leader>sh", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })

-- gopher
vim.keymap.set(
  "n",
  "<leader>gsj",
  "<cmd> GoTagAdd json <CR>",
  { desc = "Add json struct tags" }
)

vim.keymap.set(
  "n",
  "<leader>gsy",
  "<cmd> GoTagAdd yaml <CR>",
  { desc = "Add yaml struct tags" }
)
