return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({ async = false, lsp_fallback = true })
      end,
      mode = "",
      desc = "format",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { "lua_ls" },
      elixir = { "mix" },
      eelixir = { "mix" },
      heex = { "mix" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = { timeout_ms = 500 },
  },
}
