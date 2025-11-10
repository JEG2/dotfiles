-- Requirements:
-- * `brew install fzf`
-- * `brew install fd`
-- * `brew install ripgrep`
local function get_current_buffers_directory()
  local current_buffer = string.gsub(
    vim.api.nvim_buf_get_name(0),
    "^oil://",
    "",
    1
  )
  if current_buffer == "" then
    return vim.fn.getcwd()
  else
    return vim.fn.fnamemodify(current_buffer, ":h")
  end
end

local function find_project_directory()
  local buffer_dir = get_current_buffers_directory()
  local git_root = vim.fn.systemlist(
    "git -C " .. vim.fn.escape(buffer_dir, " ") .. " rev-parse --show-toplevel"
  )[1]
  if vim.v.shell_error ~= 0 then
    return vim.fn.getcwd()
  end
  return git_root
end

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- buffer
    { "<Leader>bf", function()
      require("fzf-lua").buffers({})
    end, { desc = "buffer find" } },
    -- file
    { "<Leader>fd", function()
      local saved_wd = vim.fn.getcwd()
      local documents_dir = "/Users/james/Documents/"
      if documents_dir ~= saved_wd then
        vim.cmd("cd " .. documents_dir)
      end
      require("fzf-lua").fzf_exec("fd --type dir", {
        prompt = "~/Documents/",
        actions = {
          ["default"] = function(selected)
            if selected and #selected == 1 then
              vim.cmd("e " .. selected[1])
              vim.cmd("cd " .. get_current_buffers_directory())
            elseif documents_dir ~= saved_wd then
              vim.cmd("cd " .. saved_wd)
            end
          end,
        },
      })
    end, { desc = "file init" } },
    { "<Leader>fi", function()
      require("fzf-lua").files({
        cwd = "/Users/james/Documents/dotfiles/config/nvim/"
      })
    end, { desc = "file init" } },
    { "<Leader>ff", function()
      require("fzf-lua").files({ cwd = get_current_buffers_directory() })
    end, { desc = "file find" } },
    { "<Leader>fp", function()
      require("fzf-lua").files({ cwd = find_project_directory() })
    end, { desc = "file (find in) project" } },
    { "<Leader>fw", function()
      require("fzf-lua").files({})
    end, { desc = "file (find in) working directory" } },
    -- search
    { "<Leader>sa", function()
      require("fzf-lua").treesitter({})
    end, { desc = "search AST (in buffer)" } },
    { "<Leader>sg", function()
      require("fzf-lua").lgrep_curbuf({})
    end, { desc = "search grep (in buffer)" } },
    { "<Leader>sl", function()
      require("fzf-lua").lsp_finder({})
    end, { desc = "search LSP references" } },
    { "<Leader>sp", function()
      local saved_wd = vim.fn.getcwd()
      local project_dir = find_project_directory()
      if project_dir ~= saved_wd then
        vim.cmd("cd " .. project_dir)
      end
      require("fzf-lua").live_grep({ rg_glob = true })
      if project_dir ~= saved_wd and project_dir == vim.fn.getcwd() then
        vim.cmd("cd " .. saved_wd)
      end
    end, { desc = "search grep (in project)" } },
    { "<Leader>sr", function()
      require("fzf-lua").resume({})
    end, { desc = "search resume" } },
  },
  opts = function(_, _)
    local fzf = require("fzf-lua")
    local defaults = fzf.config.defaults
    local actions = fzf.actions

    defaults.keymap.fzf["ctrl-l"] = "toggle"
    defaults.keymap.fzf["ctrl-o"] = "select-all+accept"

    defaults.actions.files["ctrl-I"] = actions.toggle_ignore
    defaults.actions.files["ctrl-H"] = actions.toggle_hidden
  end
}
