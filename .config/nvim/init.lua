vim.g.neovim_mode = vim.env.NEOVIM_MODE or "default"
if vim.g.neovim_mode == "skitty" then
	vim.wait(500, function()
		return false
	end)
	-- wait for X miliseconds without doing anything.
	-- Supposed to prevent an issue if loading skitty immediately.
end

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
		vim.api.nvim_set_hl(0, "@declaration.other", { fg = "#69AEC8" })
		vim.api.nvim_set_hl(0, "@other.type_name", { fg = "#D5BBFA" }) -- 213,187,250
		vim.api.nvim_set_hl(0, "@project.properties", { fg = "#89C0B3" })
		vim.api.nvim_set_hl(0, "@type.primitive", { fg = "#D5BBFA" }) -- 213,187,250
		vim.api.nvim_set_hl(0, "@type.swiftui", { fg = "#D5BBFA" }) -- 213,187,250
		vim.api.nvim_set_hl(0, "@member.definition", { fg = "#69AEC8" }) -- 105,174,200
	end,
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
