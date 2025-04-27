return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "swift", "javascript", "typescript", "css", "c", "lua", "vim", "vimdoc", "query", "elixir", "heex",  "html", "vimdoc" , "vimdoc", "svelte"},
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    }
}
