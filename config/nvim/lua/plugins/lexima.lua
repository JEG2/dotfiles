return {
  "cohama/lexima.vim",
  config = function()
    vim.api.nvim_call_function(
      "lexima#add_rule",
      { {
        char = "<",
        input_after = ">",
        filetype = { "eelixir", "heex", "html" }
      } }
    )
  end
}
