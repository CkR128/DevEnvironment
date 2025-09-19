local progress_handle
return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		-- Uncomment a picker that you want to use, snacks.nvim might be additionally
		-- useful to show previews and failing snapshots.

		-- You must select at least one:
		-- "nvim-telescope/telescope.nvim",
		-- "ibhagwan/fzf-lua",
		-- "folke/snacks.nvim", -- (optional) to show previews

		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-tree.lua", -- (optional) to manage project files
		"stevearc/oil.nvim", -- (optional) to manage project files
		"nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
	},
	config = function()
		require("xcodebuild").setup({
			-- put some options here or leave it empty to use default settings
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
			}),
			show_build_progress_bar = false,
			logs = {
				notify = function(message, severity)
					local fidget = require("fidget")
					if progress_handle then
						progress_handle.message = message
						if not message:find("Loading") then
							progress_handle:finish()
							progress_handle = nil
							if vim.trim(message) ~= "" then
								fidget.notify(message, severity)
							end
						end
					else
						fidget.notify(message, severity)
					end
				end,
				notify_progress = function(message)
					local progress = require("fidget.progress")

					if progress_handle then
						progress_handle.title = ""
						progress_handle.message = message
					else
						progress_handle = progress.handle.create({
							message = message,
							lsp_client = { name = "xcodebuild.nvim" },
						})
					end
				end,
			},
		})
	end,
}
