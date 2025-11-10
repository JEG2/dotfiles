-- buffer
vim.keymap.set("n", "<Leader><Tab>", "<CMD>b#<CR>", { desc = "buffer previous" })
vim.keymap.set("n", "<Leader>bd", "<CMD>bd<CR>", { desc = "buffer delete" })
vim.keymap.set(
  "n",
  "<Leader>bt", "<CMD>terminal<CR>i",
  { desc = "buffer terminal" }
)

-- file
vim.keymap.set("n", "<Leader>fs", "<CMD>w<CR>", { desc = "file save" })
vim.keymap.set(
  "n",
  "<Leader>fge",
  "<CMD>e %:h/.git/info/exclude<CR>",
  { desc = "file git exclude" }
)

-- info
vim.keymap.set("n", "<Leader>il", "<CMD>LspInfo<CR>", { desc = "info LSP" })
vim.keymap.set("n", "<Leader>ip", "<CMD>Lazy<CR>", { desc = "info packages" })
vim.keymap.set("n", "<Leader>is", "<CMD>Mason<CR>", { desc = "info servers" })

-- quickfix
vim.keymap.set("n", "<Leader>qb", "<CMD>copen<CR>", { desc = "quickfix browse" })
vim.keymap.set("n", "<Leader>qf", "<CMD>cfirst<CR>", { desc = "quickfix first" })
vim.keymap.set("n", "<Leader>ql", "<CMD>clast<CR>", { desc = "quickfix last" })
vim.keymap.set("n", "<Leader>qn", "<CMD>cnext<CR>", { desc = "quickfix next" })
vim.keymap.set("n", "<Leader>qp", "<CMD>cprev<CR>", { desc = "quickfix previous" })

-- search
vim.keymap.set("n", "<Leader>sd", "<CMD>noh<CR>", { desc = "search delete" })

-- tag
vim.keymap.set("i", "<C-Space><<", function(args)
  vim.snippet.expand("<${1:div}$2>$0</$1>")
end, { desc = "tag insert" })
vim.keymap.set("i", "<C-Space></", function(args)
  vim.snippet.expand("<${1:img}$2 />$0")
end, { desc = "tag (self-closing) insert" })
vim.keymap.set("i", "<C-Space><#", function(args)
  vim.snippet.expand("<!-- $0 -->")
end, { desc = "tag (comment) insert" })
vim.keymap.set("i", "<C-Space><%", function(args)
  vim.snippet.expand("<% $0 %>")
end, { desc = "tag (embedded) insert" })
vim.keymap.set("i", "<C-Space><=", function(args)
  vim.snippet.expand("<%= $0 %>")
end, { desc = "tag (embedded insertion) insert" })
vim.keymap.set("i", "<C-Space><i", function(args)
  vim.snippet.expand("<%= if $1 do %>\n  $0\n<% end %>")
end, { desc = "tag (embedded if) insert" })
vim.keymap.set("i", "<C-Space><e", function(args)
  vim.snippet.expand("<%= if $1 do %>\n  $2\n<% else %>\n  $0\n<% end %>")
end, { desc = "tag (embedded if/else) insert" })
vim.keymap.set("i", "<C-Space><f", function(args)
  vim.snippet.expand("<%= for ${1:item} <- ${2:enum} do %>\n  $0\n<% end %>")
end, { desc = "tag (embedded for) insert" })

--window
vim.keymap.set("n", "<Leader>wd", "<CMD>close<CR>", { desc = "window delete" })
vim.keymap.set(
  "n",
  "<Leader>wH",
  "<CMD>vsplit<CR>",
  { desc = "window (split) left" }
)
vim.keymap.set(
  "n",
  "<Leader>wJ",
  "<CMD>belowright split<CR>",
  { desc = "window (split) below" }
)
vim.keymap.set(
  "n",
  "<Leader>wK",
  "<CMD>split<CR>",
  { desc = "window (split) above" }
)
vim.keymap.set(
  "n",
  "<Leader>wL",
  "<CMD>belowright vsplit<CR>",
  { desc = "window (split) right" }
)
vim.keymap.set(
  "n",
  "<Leader>ws",
  "<CMD>mksession<CR>",
  { desc = "window save" }
)
vim.keymap.set(
  "n",
  "<Leader>wr",
  "<CMD>source Session.vim<CR>",
  { desc = "window restore" }
)
