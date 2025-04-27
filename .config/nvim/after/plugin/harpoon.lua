local harpoon = require("harpoon")
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end


vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add to harpoon list" })
vim.keymap.set("n", "<leader>hp", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Picker" })
vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon telescope" })

vim.keymap.set("n", "<leader><C-j>", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
vim.keymap.set("n", "<leader><C-k>", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
vim.keymap.set("n", "<leader><C-l>", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
vim.keymap.set("n", "<leader><C-;>", function() harpoon:list():select(4) end, { desc = "harpoon file 4" })

vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon Prev file" })
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon Next file" })

