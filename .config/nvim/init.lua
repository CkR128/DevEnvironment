vim.g.neovim_mode = vim.env.NEOVIM_MODE or "default"
if vim.g.neovim_mode == "skitty" then
	vim.wait(500, function()
		return false
	end)
	-- wait for X miliseconds without doing anything.
	-- Supposed to prevent an issue if loading skitty immediately.
end

AppleColors = {
	plain_Text = "#DFDFE0",
	comments = "#818C97",
	marks = "#A5B0BD",
	strings = "#EF8876",
	characters_numbers = "#D6CA86",
	-- Skip Regex
	keywords = "#EE81B0",
	preprocessor = "#F2A55F",
	uRLs = "#7198F8",
	attributes = "#C4996F",
	type_Declaration = "#89DCFB",
	other_Declaration = "#69AEC8",
	project_Class_Type_Names = "#BBF0E4",
	project_Function_Method_Constants_Properties_Globals = "#89C0B4",
	other_Class_Type = "#D5BCFA",
	other_Function_Method_Constants_Properties_Globals = "#AA83E5",
	preprocessor_Macros = "#F2A55F",
	heading = "#AB399E",

	background = "#292A2F",
	selection = "#666E81",
	current_line = "#303238",
	cursor = "#3478F6",
	invisibles = "#565F6C",

	math_operators = "#E0E0E1",
}

require("config.set")
require("config.remap")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
}, {})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "swift" },
	callback = function()
		vim.treesitter.start()
		vim.api.nvim_set_hl(0, "@declaration.other", { fg = AppleColors.other_Declaration })
		vim.api.nvim_set_hl(0, "@other.type_name", { fg = AppleColors.other_Class_Type }) -- 213,187,250
		vim.api.nvim_set_hl(
			0,
			"@project.properties",
			{ fg = AppleColors.project_Function_Method_Constants_Properties_Globals }
		)
		vim.api.nvim_set_hl(
			0,
			"@type.primitive",
			{ fg = AppleColors.other_Function_Method_Constants_Properties_Globals }
		) -- 213,187,250
		vim.api.nvim_set_hl(0, "@type.swiftui", { fg = AppleColors.other_Class_Type }) -- 213,187,250
		vim.api.nvim_set_hl(0, "@member.definition", { fg = AppleColors.other_Declaration }) -- 105,174,200
	end,
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
