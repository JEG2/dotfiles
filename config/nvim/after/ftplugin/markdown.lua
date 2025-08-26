vim.keymap.set(
  "n", 
  "<LocalLeader>p", 
  "<CMD>silent !open -a 'Marked 2.app' %:p<CR>", 
  { buffer = true, desc = "preview" }
)
