return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
        },
        build = ':TSUpdate',
        event = "BufReadPost",
        opts = {
            ensure_installed = "all",
            highlight = {
                enable = true,
                -- when nvim lsp/clangd highlighting works
                -- disable = { "cpp", "c" },
                disable = {
                    'help',
                },
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

            local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
            parser_config['jjdescription'] = {
                install_info = {
                    url = "https://github.com/kareigu/tree-sitter-jjdescription.git",
                    files = { "src/parser.c" },
                    branch = "dev",
                },
                filetype = "jj",
            }
        end,
    },
    'nvim-treesitter/nvim-treesitter-refactor',
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            enable = true,
            max_lines = 6,
            separator = "─",
        },
    }
}
