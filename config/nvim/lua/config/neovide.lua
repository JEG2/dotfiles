-- https://neovide.dev/configuration.html
if vim.g.neovide then
  vim.o.guifont = "DejaVuSansM Nerd Font Mono:h16"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_remember_window_size = true
end

-- Allow clipboard copy paste in neovide
-- if vim.g.neovide then
--   vim.keymap.set('n', '<D-s>', ':w<CR>', { desc = 'save' })
--   vim.keymap.set('v', '<D-c>', '"+y') -- Copy
--   vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
--   vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
--   vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
--   vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
-- end
