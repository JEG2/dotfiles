-- Requirements:
-- * `asdf install nodejs`
return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "elixirls", "emmet_ls", "lua_ls", "tailwindcss" },
  },
  dependencies = {
    { "folke/neodev.nvim",    opts = {} },
    { "mason-org/mason.nvim", opts = {} },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config.elixirls = {
          cmd = { "elixir-ls" },
          -- set default capabilities for cmp lsp completion source
          capabilities = capabilities
        }

        vim.lsp.config.tailwindcss = {
          filetypes = { "css", "eelixir", "heex", "html", "javascript" },
          -- set default capabilities for cmp lsp completion source
          capabilities = capabilities,
          init_options = {
            userLanguages = {
              elixir = "phoenix-heex",
              eelixir = "html-eex",
              heex = "phoenix-heex"
            }
          },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  'class[:]\\s*"([^"]*)"'
                }
              }
            }
          }
        }

        vim.lsp.config.emmet_ls = {
          filetypes = { "html", "css", "eelixir", "heex" },
          capabilities = capabilities
        }

        vim.lsp.config.lua_ls = {
          settings = {
            Lua = {
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
              }
            }
          }
        }
      end,
    }
  }
}
