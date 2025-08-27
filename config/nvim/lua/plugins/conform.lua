return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "lua_ls" },
      elixir = { "mix" },
      eelixir = { "mix" },
      heex = { "mix" }
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback"
    }
  }
}
