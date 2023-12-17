local plugins = {

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			auto_install = true,
			ensure_installed = {
				"lua",
			},
		},
	},

	{
		"williamboman/mason.nvim",
		opts = {
			automatic_installation = true,
			ensure_installed = {
				"lua-language-server",
				"stylua",
			},
		},
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
		config = function()
			require("custom.configs.formatter")
		end,
	},
}

return plugins
