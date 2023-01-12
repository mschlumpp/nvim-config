return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = "BufReadPost",
        opts = {
            ensure_installed = "all",
            highlight = {
                enable = true,
                -- when nvim lsp/clangd highlighting works 
                -- disable = { "cpp", "c" },
                disable = { 'help' },
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
        },
        config = function(plugin, opts)
            require 'nvim-treesitter.configs'.setup(opts)
        end,
    },
    'nvim-treesitter/nvim-treesitter-refactor',
}

