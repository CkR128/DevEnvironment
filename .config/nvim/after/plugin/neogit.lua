local neogit = require('neogit')

-- open using defaults
vim.keymap.set("n", "<leader>git", function() 
    neogit.open()
end, { desc = "NeoGit Open" })
