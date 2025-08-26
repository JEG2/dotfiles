return {
  "hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline"
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			snippet = {
				-- you must specify a snippet engine
				expand = function(args)
					-- using neovim v0.10 native snippet feature
					vim.snippet.expand(args.body)
				end,
			},
		})
	end,
}
