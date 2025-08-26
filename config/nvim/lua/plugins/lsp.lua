return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
      ensure_installed = { "elixirls", "lua_ls" },
  },
  dependencies = {
    { "folke/neodev.nvim", opts = {} },
    { "mason-org/mason.nvim", opts = {} },
    {
    	"neovim/nvim-lspconfig",
	    config = function()
	      local lspconfig = require("lspconfig")

	      local capabilities = require("cmp_nvim_lsp").default_capabilities()
	      lspconfig.elixirls.setup({
		      cmd = { "elixir-ls" },
		      -- set default capabilities for cmp lsp completion source
		      capabilities = capabilities,
	      })

        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
              }
            }
          }
        })
	    end,
    }
  }
}
