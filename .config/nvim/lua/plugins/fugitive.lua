return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })

		local fugitiveGroup = vim.api.nvim_create_augroup("ckrobinson", {})
		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWinEnter", {
			group = fugitiveGroup,
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				vim.keymap.set("n", "<leader>p", function()
					vim.cmd.Git("push")
				end, { buffer = bufnr, remap = false, desc = "Git Push" })

				vim.keymap.set("n", "<leader>P", function()
					vim.cmd.Git("pull", "--rebase")
				end, { buffer = bufnr, remap = false, desc = "Git Pull (rebase)" })

				vim.keymap.set("n", "<leader>u", function()
					vim.cmd.Git("push -u origin")
				end, { buffer = bufnr, remap = false, desc = "Git Push Upstream" })
			end,
		})

		vim.keymap.set("n", "gC", "<cmd>diffget //2<CR>", { desc = "Diff-Get - Current" })
		vim.keymap.set("n", "gI", "<cmd>diffget //3<CR>", { desc = "Diff-Get - Incoming" })
		vim.keymap.set("n", "gP", "<cmd>diffput //1<CR>", { desc = "Diff-Put - To Working" })
	end,
}
