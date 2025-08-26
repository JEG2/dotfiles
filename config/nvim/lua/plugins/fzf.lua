local function get_current_buffer()
  return string.gsub(vim.api.nvim_buf_get_name(0), "^oil://", "", 1)
end

local function get_current_buffers_directory()
  local current_buffer = get_current_buffer()
  if current_buffer == "" then
    return vim.fn.getcwd()
  else
    return vim.fn.fnamemodify(current_buffer, ":h")
  end
end

local function find_project_directory()
  local current_buffer = get_current_buffer()
  local buffer_dir
  local cwd = vim.fn.getcwd()
  if current_buffer == "" then
    buffer_dir = cwd
  else
    buffer_dir = vim.fn.fnamemodify(current_buffer, ":h")
  end

  local git_root = vim.fn.systemlist(
    "git -C " .. vim.fn.escape(buffer_dir, " ") .. " rev-parse --show-toplevel"
  )[1]
  if vim.v.shell_error ~= 0 then
    return cwd
  end
  return git_root
end

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- buffer
    {"<Leader>bf", function()
      require("fzf-lua").buffers({})
    end, { desc = "buffer find" }},
    -- file
    {"<Leader>fi", function()
      require("fzf-lua").files({
        cwd = "/Users/james/Documents/dotfiles/config/nvim/"
      })
    end, { desc = "file init" }},
    {"<Leader>ff", function()
      require("fzf-lua").files({ cwd = get_current_buffers_directory() })
    end, { desc = "file find" }},
    {"<Leader>fp", function()
      require("fzf-lua").files({ cwd = find_project_directory() })
    end, { desc = "file (find in) project" }},
    {"<Leader>fw", function()
      require("fzf-lua").files({})
    end, { desc = "file (find in) working directory" }},
    -- search
    {"<Leader>sa", function()
      require("fzf-lua").treesitter({})
    end, { desc = "search AST (in buffer)" }},
    {"<Leader>sf", function()
      require("fzf-lua").grep_curbuf({})
    end, { desc = "search fuzzy (in buffer)" }},
    {"<Leader>sg", function()
      require("fzf-lua").lgrep_curbuf({})
    end, { desc = "search grep (in buffer)" }},
    {"<Leader>sp", function()
      require("fzf-lua").live_grep({})
    end, { desc = "search grep (in project)" }},
    {"<Leader>sr", function()
      require("fzf-lua").resume({})
    end, { desc = "search resume" }},
  },
  opts = {}
}
