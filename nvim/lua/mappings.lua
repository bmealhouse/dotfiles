require "nvchad.mappings"

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
