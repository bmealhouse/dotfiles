M = {}

M.gitsigns = {
  n = {
    ["<leader>sb"] = {
      function()
        require("gitsigns").stage_buffer()
      end,
      "Stage buffer",
    },
    ["<leader>sh"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage hunk",
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
  },
}

return M
