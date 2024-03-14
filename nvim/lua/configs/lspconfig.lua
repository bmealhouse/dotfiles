local configs = require "nvchad.configs.lspconfig"

local on_init = configs.on_init
local on_attach = configs.on_attach
local capabilities = configs.capabilitie

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local servers =
  { "cssls", "eslint", "html", "jsonls", "prismals", "tailwindcss", "taplo" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.gopls.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
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

lspconfig.tsserver.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      -- TODO: test with suggestions enabled
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
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "root/**/*.yml",
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
      },
    },
  },
}
