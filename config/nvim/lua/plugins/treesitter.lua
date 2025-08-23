return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master', 
  lazy = false, 
  build = ":TSUpdate",
  config = function () 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        'bash', 
        'csv', 
        'dockerfile', 
        'eex', 
        'elixir', 
        'erlang', 
        'heex', 
        'html', 
        'javascript', 
        'json', 
        'lua', 
        'markdown', 
        'markdown_inline', 
        'mermaid', 
        'terraform', 
        'toml',
        'yaml'  
      },
      highlight = { enable = true },
      indent = { enable = true } 
    })
   end
}
