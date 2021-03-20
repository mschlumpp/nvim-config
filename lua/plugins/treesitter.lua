local treesitter_config = require "nvim-treesitter.configs";

treesitter_config.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        -- when nvim lsp/clangd highlighting works 
        -- disable = { "cpp", "c" },
    },
    refactor = {
        highlight_definitions = {
            enable = true,
            disable = { "cpp", "rust" }, -- provided by lsp
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "+",
            node_incremental = "+",
            node_decremental = "_",
        }
    }
}
