return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    local lint_autogroup = vim.api.nvim_create_augroup("lint", { clear = true })

    lint.linters_by_ft = {
      elixir = { "credo" },

      bash = { "ShellCheck" },
      sh = { "ShellCheck" }
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_autogroup,
      callback = function()
        lint.try_lint()
      end
    })
  end
}
