-- https://github.com/benfrain/neovim/blob/main/lua/mappings.lua#L64
-- buffers
vim.keymap.set('n', '<Leader>bf', require('fzf-lua').buffers, { desc = 'buffer find' })

-- files
vim.keymap.set('n', '<Leader>ff', require('fzf-lua').files, { desc = 'file find' })
vim.keymap.set('n', '<Leader>fs', ':w<CR>', { desc = 'file save' })
