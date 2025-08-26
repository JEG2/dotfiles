return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      theme = "dragon",
      overrides = function(colors)
        return {
          EndOfBuffer = { fg = colors.theme.ui.bg_p2 }
        }
      end
    })
    vim.cmd.colorscheme("kanagawa")
  end,
}
