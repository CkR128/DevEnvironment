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

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Delete null-reg, Paste" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to Clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "[D]elete to null-reg" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "[Y]ank Line to Clipboard" })
vim.keymap.set("n", "<leader>o", "o<ESC>", { desc = "[o] Newline below - in Normal Mode" })
vim.keymap.set("n", "<leader>O", "O<ESC>", { desc = "[O] Newline above - in Normal Mode" })

vim.keymap.set("n", "Q", "<nop>")

local function is_in_tmux()
	return vim.env.TMUX ~= nil
end
vim.keymap.set("n", "<C-f>", function()
	if is_in_tmux() then
		vim.fn.system("tmux neww tmux-sessionizer")
	else
		print("Not running tmux, can not run sessionizer.")
		vim.notify("Not running tmux, can not run sessionizer.")
	end
end, { desc = "Swap project - Tmux Sessionizer" })

vim.keymap.set("n", "<leader><C-R>", "sp <CR> :term python % <CR>")

vim.keymap.set({ "n", "v" }, "G", "gg", { noremap = true })
vim.keymap.set({ "n", "v" }, "gg", "G", { noremap = true })

vim.keymap.set("n", "<C-c>j", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-c>k", "<cmd>cprev<CR>")

local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, bufopts, { desc = "Open [E]rror." })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "t", "<Nop>", { buffer = true })
	end,
})
