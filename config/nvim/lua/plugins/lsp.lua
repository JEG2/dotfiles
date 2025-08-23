return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
      ensure_installed = { "elixirls", "lua_ls" },
  },
  dependencies = {
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
	    end,
    }
  }
}
