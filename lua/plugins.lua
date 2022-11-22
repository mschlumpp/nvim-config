-- Bootstrap packet.nvim if it's not installed
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd('packadd packer.nvim')

return require('packer').startup(function ()
    use {
        'wbthomason/packer.nvim',
        opt = true,
    }
    use {
        'nvim-lualine/lualine.nvim',
        config = [[require('plugins.lualine')]],
    }
    use 'chriskempson/base16-vim'
    use 'rainglow/vim'
    use {
        'sonph/onehalf',
        rtp = 'vim',
    }
    use 'rmehri01/onenord.nvim'
    use 'olimorris/onedarkpro.nvim'
    use 'ray-x/aurora'
    use {
        'projekt0n/github-nvim-theme',
        config = function()
            vim.cmd('colorscheme github_light_default')
        end
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {{'kyazdani42/nvim-web-devicons', opt = true}},
        cmd = {'NvimTreeToggle', 'NvimTreeFindFile'},
    }
    use {
        'nanotech/jellybeans.vim',
        config = function() 
            vim.g.jellybeans_overrides = {
                GitGutterAdd = {guifg = '5af78e', guibg = '333333'},
                GitGutterModify = {guifg = '57c7ff', guibg = '333333'},
                GitGutterDelete = {guifg = 'ff5c57', guibg = '333333'},
                GitGutterChangeDelete = {guifg = 'ff6ac1', guibg = '333333'},
            }
        end
    }
    -- use 'dstein64/nvim-scrollview'
    use 'tpope/vim-sleuth'
    use 'kevinhwang91/nvim-bqf'
    use {
        'mbbill/undotree',
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = [[require('plugins.gitsigns')]],
    }
    use { 
        'akinsho/toggleterm.nvim',
        keys = {[[<c-\>]]},
        config = [[require('plugins.toggleterm')]],
    }
    use {
        'folke/which-key.nvim',
        config = [[require('plugins.which_key')]],
    }
    use {
        'mhinz/vim-sayonara',
    }
    use {
        'hrsh7th/nvim-cmp',
        config = [[require('plugins.completion')]],
        requires = {
            'hrsh7th/vim-vsnip', 
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-omni',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lua',
            -- For clangd score sorter
            'p00f/clangd_extensions.nvim',
        },
    }
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'onsails/lspkind-nvim',
            'gfanto/fzf-lsp.nvim',
            'j-hui/fidget.nvim',
            'jose-elias-alvarez/null-ls.nvim',
            'nvim-lua/plenary.nvim',
            'SmiteshP/nvim-navic',
            'p00f/clangd_extensions.nvim',
        },
        config = [[require('plugins.lsp')]]
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('plugins.treesitter')]],
    }
    use {
        'nvim-treesitter/nvim-treesitter-refactor',
        after = {'nvim-treesitter'},
    }
    use {
        'cespare/vim-toml',
        ft = 'toml',
    }
    use {
        'rust-lang/rust.vim',
        ft = 'rust',
    }
    use {
        'Saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        requires = {
            'jose-elias-alvarez/null-ls.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require'crates'.setup {
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                }
            }
        end,
    }
    use {
        'LnL7/vim-nix',
        ft = 'nix',
    }
    use {
        'NoahTheDuke/vim-just',
    }
    use {
        'bazelbuild/vim-ft-bzl',
        ft = 'bzl',
    }
    use {
        'barreiroleo/ltex_extra.nvim',
        module = 'ltex_extra',
    }
    use {
        'lervag/vimtex',
        ft = 'tex',
        config = [[
            vim.g.tex_flavor = 'latex'
        ]]
    }
    use {
        'ziglang/zig.vim',
        ft = 'zig',
    }
    use {
        'jceb/vim-orgmode',
        ft = 'org',
    }
    use {
        'bakpakin/fennel.vim',
        ft = 'fnl',
    }
    use {
        'ahf/cocci-syntax',
        ft = 'cocci',
    }
    use {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
    }
    use {
        'tpope/vim-fugitive',
        cmd = 'Git',
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    }
    use {
        'kylechui/nvim-surround',
        config = function()
            require'nvim-surround'.setup {
                keymaps = {
                    insert          = '<C-g>z',
                    insert_line     = '<C-g>Z',
                    normal          = 'gz',
                    normal_cur      = 'gZ',
                    normal_line     = 'gzgz',
                    normal_cur_line = 'gZgZ',
                    visual          = 'gz',
                    visual_line     = 'gZ',
                    delete          = 'gzd',
                    change          = 'gzc',
                },
            }
        end,
    }
    use {
        'cbochs/portal.nvim',
        config = function() 
            require 'portal'.setup {
            }
            vim.keymap.set('n', '<leader>o', require('portal').jump_backward, {})
            vim.keymap.set('n', '<leader>i', require('portal').jump_forward, {})
        end,
    }
    use {
        'ggandor/leap.nvim',
        requires = {'tpope/vim-repeat'},
        config = [[
            require'leap'.add_default_mappings()
        ]],
    }
    use {
        "folke/zen-mode.nvim",
        requires = {'folke/twilight.nvim'},
        config = function()
            require("zen-mode").setup {
                window = {
                    options = {
                        number = false,
                    },
                },
                plugins = {
                    gitsigns = { enabled = true },
                },
            }
        end,
    }
    use {
        'junegunn/vim-easy-align',
        keys = {{'x', 'ga'}, {'n', 'ga'}},
        config = [[
            vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', { silent = true })
            vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', { silent = true })
        ]],
    }
    use {
        'windwp/nvim-autopairs',
        config = [[
            require('nvim-autopairs').setup({
                fast_wrap = {},
            })
        ]]
    }
    use {
        'gbprod/yanky.nvim',
        config = function()
            require('yanky').setup { }
            vim.keymap.set({'n', 'x'}, 'p', '<Plug>(YankyPutAfter)')
            vim.keymap.set({'n', 'x'}, 'P', '<Plug>(YankyPutBefore)')
            vim.keymap.set({'n', 'x'}, 'gp', '<Plug>(YankyGPutAfter)')
            vim.keymap.set({'n', 'x'}, 'gP', '<Plug>(YankyGPutBefore)')
            vim.keymap.set('n', '<c-n>', '<Plug>(YankyCycleForward)')
            vim.keymap.set('n', '<c-p>', '<Plug>(YankyCycleBackward)')
            vim.keymap.set('n', '<m-p>', '<cmd>YankyRingHistory<cr>')
        end,
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    winblend = 5,
                    dynamic_preview_title = true,
                    mappings = {
                        i = {
                            ['<c-n>'] = require'telescope.actions'.cycle_history_next,
                            ['<c-p>'] = require'telescope.actions'.cycle_history_prev,
                            ['<c-j>'] = require'telescope.actions'.move_selection_next,
                            ['<c-k>'] = require'telescope.actions'.move_selection_previous,
                        }
                    },
                },
                extensions = {
                    ['ui-select'] = {
                        require("telescope.themes").get_cursor {
                        }
                    },
                },
            }
            telescope.load_extension('ui-select')
            telescope.load_extension('fzy_native')
        end,
    }
    use {
        'skywind3000/asyncrun.vim',
        requires = {
            { 'skywind3000/asynctasks.vim', opt = true }
        },
        cmd = {'AsyncRun'},
        config = [[vim.g.asyncrun_open = 8]],
    }
    use {
        'lambdalisue/suda.vim',
        cmd = {'SudaRead', 'SudaWrite'},
    }
    use {
        'editorconfig/editorconfig-vim'
    }
    use {
        'kevinhwang91/rnvimr',
        config = [[
            vim.api.nvim_set_keymap('n', '<M-o>', '<cmd>RnvimrToggle<cr>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('t', '<M-o>', '<cmd>RnvimrToggle<cr>', { noremap = true, silent = true })
        ]]
    }
    use {
        'junegunn/fzf.vim',
        requires = {'junegunn/fzf'},
        config = function()
            vim.api.nvim_exec([[
                function! RipgrepFzf(query, fullscreen)
                    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
                    let initial_command = printf(command_fmt, shellescape(a:query))
                    let reload_command = printf(command_fmt, '{q}')
                    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
                    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
                endfunction
                command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
            ]], false)
        end,
    }
    use {
        'ferrine/md-img-paste.vim',
        ft = 'markdown',
        setup = function()
            vim.g['mdip_imgdir'] = 'media'
        end,
        config = function()
            vim.api.nvim_exec([[
                autocmd FileType markdown nmap <buffer><silent> <leader>mp <cmd>call mdip#MarkdownClipboardImage()<cr>
            ]], false)
        end,
    }
end)
