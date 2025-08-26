-- buffer
vim.keymap.set("n", "<Leader><Tab>", "<CMD>b#<CR>", { desc = "buffer delete" })
vim.keymap.set("n", "<Leader>bd", "<CMD>bd<CR>", { desc = "buffer delete" })

-- file
vim.keymap.set("n", "<Leader>fs", "<CMD>w<CR>", { desc = "file save" })

-- info
vim.keymap.set("n", "<Leader>il", "<CMD>LspInfo<CR>", { desc = "info LSP" })
vim.keymap.set("n", "<Leader>ip", "<CMD>Lazy<CR>", { desc = "info packages" })
vim.keymap.set("n", "<Leader>is", "<CMD>Mason<CR>", { desc = "info servers" })

-- search
vim.keymap.set("n", "<Leader>sd", "<CMD>noh<CR>", { desc = "file save" })
