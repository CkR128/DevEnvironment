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
			})
			vim.cmd.colorscheme("xcodedark")
		end,
	},
}
