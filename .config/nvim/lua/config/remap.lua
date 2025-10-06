vim.keymap.set("n", "<leader>pe", "<cmd>Rex <CR>", { desc = "[E]xplorer" })

vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { desc = "[L]sp [R]estart" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank to end of line
vim.keymap.set("n", "Y", "yg$")
-- Pull next line to end of current line
vim.keymap.set("n", "J", "mzJ`z")
-- Move Up/Down, keep cursor centered in screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- ?
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Delete null-reg, Paste" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "[D]elete to null-reg" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to Clipboard" })
vim.keymap.set({ "n" }, "<leader>Y", '"+Y', { desc = "[Y]ank Line to Clipboard" })

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

-- Swap G and gg, gg to go down.
vim.keymap.set({ "n", "v" }, "G", "gg", { noremap = true })
vim.keymap.set({ "n", "v" }, "gg", "G", { noremap = true })

local function toggleQuickFix()
	local qf_win_info = vim.fn.getqflist({ winid = 0 })
	if qf_win_info.winid ~= 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end
vim.keymap.set({ "n" }, "]q", "<cmd>try | cnext | catch | cfirst | catch | endtry<CR>")
vim.keymap.set({ "n" }, "[q", "<cmd>try | cprev | catch | clast  | catch | endtry<CR>")
vim.keymap.set({ "n" }, "<leader>q", toggleQuickFix, { desc = "Toggle [Q]uickfix" })

local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, bufopts, { desc = "Expand [E]rror." })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "[Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-M-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-M-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-M-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-M-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

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
