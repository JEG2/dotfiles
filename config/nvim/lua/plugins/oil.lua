return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = { },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {"<Leader>fb", "<CMD>Oil<CR>", { desc = "file browse" }}
  },
  lazy = false,
}
