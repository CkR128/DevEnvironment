vim.api.nvim_create_user_command("ReloadTypr", function()
	local opt = {
		plugins = { "typr" },
	}
	require("lazy").reload(opt)
end, { nargs = 0, desc = "Reload Typr" })
vim.keymap.set("n", "<leader>rr", "<cmd>ReloadTypr<cr><cmd>Typr<cr>", { desc = "Reload and Run typr" })
-- vim.keymap.set("n", "<leader>rr", "", { desc = "Run typr" })
return {
	"nvzone/typr",
	dependencies = "nvzone/volt",
	opts = {},
	cmd = { "Typr", "TyprStats" },
}
