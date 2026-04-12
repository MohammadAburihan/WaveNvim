require("configs.mapping")

-- this one for resize window
vim.keymap.set('n', '<M-k>', '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<M-j>', '<Cmd>resize -2<CR>')
vim.keymap.set('n', '<M-l>', '<Cmd>vertical resize +2<CR>')
vim.keymap.set('n', '<M-h>', '<Cmd>vertical resize -2<CR>')
