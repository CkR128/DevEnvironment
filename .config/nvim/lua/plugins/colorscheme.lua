function ColorMyPencils(color)
	if vim.env.TERM:match("screen") then
		vim.opt.termguicolors = false
		color = color or "xcodedark"
		vim.cmd.colorscheme(color)
		return
	end
	color = color or "xcodedark"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "EdenEast/nightfox.nvim" },
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			})

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")

			ColorMyPencils()
		end,
	},
	{
		"altercation/vim-colors-solarized",
		lazy = false, -- load immediately
		config = function()
			-- Force 256-color mode (important for screen)
			vim.g.solarized_termcolors = 256
			vim.g.seoul256_background = 236
			-- Disable truecolor if inside screen
			if vim.env.TERM:match("screen") then
				vim.opt.termguicolors = false
			else
				vim.opt.termguicolors = true
			end
			-- Set the colorscheme

			ColorMyPencils()
		end,
	},
	{
		"joshdick/onedark.vim",
		lazy = false,
		config = function()
			if vim.env.TERM:match("screen") then
				vim.opt.termguicolors = false
			else
				vim.opt.termguicolors = true
			end

			ColorMyPencils()
		end,
	},
	{
		"junegunn/seoul256.vim",
		lazy = false,
		config = function()
			if vim.env.TERM:match("screen") then
				vim.opt.termguicolors = false
			else
				vim.opt.termguicolors = true
			end

			ColorMyPencils()
		end,
	},
	{
		"AlessandroYorba/Alduin",
		lazy = false,
		config = function()
			vim.g.alduin_Shout_Become_Ethereal = 1
			if vim.env.TERM:match("screen") then
				vim.opt.termguicolors = false
			else
				vim.opt.termguicolors = true
			end

			ColorMyPencils()
		end,
	},
	{
		"fraeso/xcodedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("xcodedark").setup({
				transparent = false, -- or false if you prefer solid background
				integrations = {
					telescope = true,
					nvim_tree = true,
					gitsigns = true,
					bufferline = true,
					incline = true,
					lazygit = true,
					which_key = true,
					notify = true,
					snacks = true,
					blink = true,
				},
				terminal_colors = true,
				color_overrides = {
					bg = AppleColors.background, -- New background color
					keyword = AppleColors.keywords, -- Keywords (var, let, if, class, func) - Pink
					string = AppleColors.strings, -- String literals - Coral red
					comment = AppleColors.comments, -- Comments - Muted gray
					number = AppleColors.characters_numbers, -- Numbers and numeric literals - Warm yellow
					boolean = AppleColors.keywords, -- Booleans (true, false) - Same as keywords
					function_name = AppleColors.other_Declaration, -- Function names and calls - Green (more accurate)
					variable = AppleColors.plain_Text, -- Variables and identifiers - White: 223, 223, 224
					constant = AppleColors.other_Function_Method_Constants_Properties_Globals, -- Constants - Light blue (not yellow)
					type = AppleColors.type_Declaration, -- Types and classes - Light blue
					property = AppleColors.project_Function_Method_Constants_Properties_Globals, -- Object properties - Green #89C0B3, Blue #69AEC8
					parameter = AppleColors.other_Declaration, -- Function parameters - Lighter, easier on the eyes purple
					preprocessor = AppleColors.keywords, -- Preprocessor directives, imports - Pink like keywords
					attribute = AppleColors.attributes, -- Attributes and decorators - Orange
					operator = AppleColors.math_operators, -- Operators (+, -, =, etc.) - White
					punctuation = AppleColors.plain_Text, -- Punctuation marks - White

					-- Swift/Objective-C specific
					swift_attribute = AppleColors.keywords, -- @objc, @available, etc.
					objc_directive = AppleColors.keywords, -- #pragma, #import - Pink like keywords

					-- UI Elements (Updated)
					cursor = AppleColors.cursor, -- New cursor color Blue
					cursor_line = AppleColors.current_line, -- Current line highlight
					selection = AppleColors.selection, -- New selection background color (matches keyword)
				},
			})
			vim.cmd.colorscheme("xcodedark")
		end,
	},
}
