require("configs.mapping")

-- this one for resize window
vim.keymap.set({'n', 't'}, '<M-k>', '<Cmd>resize +2<CR>')
vim.keymap.set({'n', 't'}, '<M-j>', '<Cmd>resize -2<CR>')
vim.keymap.set({'n', 't'}, '<M-l>', '<Cmd>vertical resize +2<CR>')
vim.keymap.set({'n', 't'}, '<M-h>', '<Cmd>vertical resize -2<CR>')

-- keymap for convert file into pdf
vim.keymap.set("n", "<leader>pdf", "<cmd>!enscript % -p - | ps2pdf - %:r.pdf<CR>", { silent = true })

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.signcolumn = "yes"
