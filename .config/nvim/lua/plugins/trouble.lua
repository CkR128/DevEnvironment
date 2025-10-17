return {
	"folke/trouble.nvim",
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>tD",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "[T]rouble Global Diagnostics",
		},
		{
			"<leader>td",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "[T]rouble Buffer Diagnostics",
		},
		-- {
		-- 	"<leader>cs",
		-- 	"<cmd>Trouble symbols toggle focus=false<cr>",
		-- 	desc = "Symbols (Trouble)",
		-- },
		-- {
		-- 	"<leader>cl",
		-- 	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		-- 	desc = "LSP Definitions / references / ... (Trouble)",
		-- },
		{
			"<leader>tl",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "[T]rouble Location List",
		},
		{
			"<leader>tQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "[T]rouble Quickfix List",
		},
	},
	config = function()
		require("trouble").setup({
			auto_open = false,
			auto_close = false,
			auto_preview = true,
			auto_jump = false,
			mode = "quickfix",
			severity = vim.diagnostic.severity.ERROR,
			cycle_results = false,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = { "XcodebuildBuildFinished", "XcodebuildTestsFinished" },
			callback = function(event)
				if event.data.cancelled then
					return
				end

				if event.data.success then
					require("trouble").close()
				elseif not event.data.failedCount or event.data.failedCount > 0 then
					if next(vim.fn.getqflist()) then
						require("trouble").open("quickfix")
					else
						require("trouble").close()
					end

					require("trouble").refresh()
				end
			end,
		})
	end,
}
