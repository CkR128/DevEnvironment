vim.keymap.set("n", "<leader>pe", vim.cmd.Ex, { desc = "[P]icker [E]xplorer" })

vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { desc = "[L]sp [R]estart" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Delete null-reg, Paste" })

vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", { desc = "[Y]ank to Clipboard" })
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d", { desc = "[D]elete to null-reg" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "[Y]ank Line to Clipboard" })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader><C-R>", "sp <CR> :term python % <CR>")

vim.keymap.set({"n", "v"}, "G", 'gg', { noremap = true})
vim.keymap.set({"n", "v"}, "gg", 'G', { noremap = true})

local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, bufopts, { desc = "Open [E]rror." })
