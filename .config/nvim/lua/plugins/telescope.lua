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
		local setGrepSearch = function()
			if vim.fn.executable("rg") == 1 then
				return nil
			else
				return {
					"grep",
					"--extended-regexp",
					"--color=never",
					"--with-filename",
					"--line-number",
					"-b",
					"--ignore-case",
					"--recursive",
					"--no-messages",
					"--exclude-dir=*cache*",
					"--exclude-dir=.git",
					"--exclude=.*",
					"--binary-files=without-match",
				}
			end
		end
		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use Telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of `help_tags` options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			-- pickers = {}
			defaults = {
				vimgrep_arguments = setGrepSearch(),
			},
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
		vim.keymap.set("n", "<leader>tf", builtin.find_files, { desc = "[T]elescope [F]ile names" })
		vim.keymap.set("n", "<leader>tw", builtin.grep_string, { desc = "[T]elescope current [W]ord" })
		vim.keymap.set("n", "<leader>td", builtin.diagnostics, { desc = "[T]elescope [D]iagnostics" })
		vim.keymap.set("n", "<leader>tr", builtin.resume, { desc = "[T]elescope [R]esume" })
		-- vim.keymap.set("n", "<leader>t.", builtin.oldfiles, { desc = '[T]elescope Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers - Telescope" })
		vim.keymap.set("n", "<leader>tnh", builtin.help_tags, { desc = "[T]elescope [N]vim [H]elp" })
		vim.keymap.set("n", "<leader>tnk", builtin.keymaps, { desc = "[T]elescope [N]vim [K]eymaps" })
		vim.keymap.set("n", "<leader>tnt", builtin.builtin, { desc = "[T]elescope [N]vim [T]elescope definitions" })
		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>tnc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[T]elescope [N]vim [C]onfig files" })

		vim.keymap.set("n", "<C-p>", builtin.git_files, {})

		vim.keymap.set("n", "<leader>tgl", builtin.live_grep, { desc = "[T]elescope by [G]rep [L]ive" })
		vim.keymap.set("n", "<leader>tgp", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "[T]elescope by [G]rep [P]rompt" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer - Telescope" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>t/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[T]elescope [/] in Open Files" })

		vim.keymap.set("n", "<leader>ts", function()
			builtin.live_grep({ search_dirs = { utils.buffer_dir() } })
		end, { desc = "[T]elescope live grep [S]earch in Current Working Directory" })
	end,
}
