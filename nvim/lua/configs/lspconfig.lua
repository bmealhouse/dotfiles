-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  "bashls",
  "cssls",
  "html",
  "jsonls",
  "marksman",
  "tailwindcss",
  "taplo",
}

-- insert work servers
vim.list_extend(servers, { "prismals" })

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local util = require "lspconfig/util"

lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      -- TODO: is this required?
      -- gofumpt = true,
      -- automatically import packages when using autocomplete
      completeUnimported = true,
      -- add placeholders to function parameters or struct fields in the completion responses
      usePlaceholders = true,
      -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
      analyses = {
        -- warn for any unused parameters
        unusedparams = true,
      },
    },
  },
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    preferences = {
      -- TODO: test with suggestions enabled.
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

lspconfig.yamlls.setup {
  on_init = nvlsp.on_init,
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
      },
    },
  },
}
