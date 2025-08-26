return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      theme = "dragon",
      overrides = function(colors)
        return {
          EndOfBuffer = { fg = colors.theme.ui.fg_dim }
        }
      end
    })
    vim.cmd.colorscheme("kanagawa")
  end,
}
