local h_pct = 0.90
local w_pct = 0.80
local w_limit = 75
local standard_setup = {
	borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	preview = { hide_on_startup = true },
	layout_strategy = "vertical",
	layout_config = {
		vertical = {
			mirror = true,
			prompt_position = "top",
			width = function(_, cols, _)
				return math.min(math.floor(w_pct * cols), w_limit)
			end,
			height = function(_, _, rows)
				return math.floor(rows * h_pct)
			end,
			preview_cutoff = 10,
			preview_height = 0.4,
		},
	},
}
local fullscreen_setup = {
	borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	preview = { hide_on_startup = false },
	layout_strategy = "flex",
	layout_config = {
		flex = { flip_columns = 100 },
		horizontal = {
			mirror = false,
			prompt_position = "top",
			width = function(_, cols, _)
				return math.floor(cols * w_pct)
			end,
			height = function(_, _, rows)
				return math.floor(rows * h_pct)
			end,
			preview_cutoff = 10,
			preview_width = 0.5,
		},
		vertical = {
			mirror = true,
			prompt_position = "top",
			width = function(_, cols, _)
				return math.floor(cols * w_pct)
			end,
			height = function(_, _, rows)
				return math.floor(rows * h_pct)
			end,
			preview_cutoff = 10,
			preview_height = 0.5,
		},
	},
}

return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					find_command = {
						"fd",
						"--type",
						"f",
						"-H",
						"--strip-cwd-prefix",
					},
				},
			},
			defaults = vim.tbl_extend("error", fullscreen_setup, {
				sorting_strategy = "ascending",
				path_display = { "filename_first" },
				mappings = {
					n = {
						["o"] = require("telescope.actions.layout").toggle_preview,
						["<C-c>"] = require("telescope.actions").close,
					},
					i = {
						["<C-o>"] = require("telescope.actions.layout").toggle_preview,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--follow", -- follow sym links
					"--hidden", -- seach hidden
					"--with-filename", -- file path with matched lines
					"--line-number", --
					"--column", -- show column number
					"--smart-case",
					-- Exclude some patterns
					"--glob=!**/.git/*",
					"--glob=!**/.idea/*",
					"--glob=!**/.vscode/*",
					"--glob=!**/build/*",
					"--glob=!**/dist/*",
					"--glob=!**/yarn.lock",
					"--glob=!**/package-lock.json",
				},
			}),
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		local utils = require("telescope.utils")
		-- Find Files by name
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({ hidden = true })
		end, { desc = "[F]ile names" })
		-- Search word under cursor across project
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "By Current [W]ord" })
		-- Search diagnostics for project
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[D]iagnostics" })
		-- Resume previous search
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[R]esume Search" })
		-- Live Grep in project. TODO: Update this to use the advanced live grep to filter by directory as well.
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		-- Search open buffers by name
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Open Buffers (File Names)" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find()
		end, { desc = "Current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>f/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "In Open Files" })

		vim.keymap.set("n", "<leader>fnh", builtin.help_tags, { desc = "Nvim [H]elp" })
		vim.keymap.set("n", "<leader>fnk", builtin.keymaps, { desc = "Nvim [K]eymaps" })
		vim.keymap.set("n", "<leader>fnt", builtin.builtin, { desc = "Nvim [T]elescope definitions" })
		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>fnc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Nvim [C]onfig files" })
	end,
}
