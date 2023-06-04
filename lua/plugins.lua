return {
    'chriskempson/base16-vim',
    'EdenEast/nightfox.nvim',
    {
        'rainglow/vim',
        name = 'rainglow',
    },
    {
        'sonph/onehalf',
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/vim")
        end,
    },
    'rmehri01/onenord.nvim',
    'olimorris/onedarkpro.nvim',
    'ray-x/aurora',
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
        priority = 1000,
        opts = { },
        config = function(plugin, opts)
            require("github-theme").setup(opts)
            vim.cmd.colorscheme('github_dark_default')
        end,
    },
    {
        'nyoom-engineering/oxocarbon.nvim'
    },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {'kyazdani42/nvim-web-devicons'},
        cmd = {'NvimTreeToggle', 'NvimTreeFindFile'},
    },
    {
        'nanotech/jellybeans.vim',
        config = function(plugin)
            vim.g.jellybeans_overrides = {
                GitGutterAdd = {guifg = '5af78e', guibg = '333333'},
                GitGutterModify = {guifg = '57c7ff', guibg = '333333'},
                GitGutterDelete = {guifg = 'ff5c57', guibg = '333333'},
                GitGutterChangeDelete = {guifg = 'ff6ac1', guibg = '333333'},
            }
        end
    },
    {
        'tpope/vim-sleuth',
        event = 'BufReadPre',
    },
    {
        'kevinhwang91/nvim-bqf',
        event = "VeryLazy",
    },
    {
        'mbbill/undotree',
        cmd = {'UndotreeToggle', 'UndotreeShow', 'UndotreeHide', 'UndotreeFocus'},
        config = function(plugin)
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },
    {
        'mhinz/vim-sayonara',
        cmd = {'Sayonara'},
    },
    {
        'nyngwang/NeoZoom.lua',
        keys = {
            { '<leader>z', function() require'neo-zoom'.neo_zoom({}) end, { silent = true }, desc = 'zoom-window' },
        },
        opts = { },
    },
    {
        'folke/twilight.nvim',
        cmd = {'Twilight', 'TwilightEnable', 'TwilightEnable'},
        opts = {},
    },
    {
        'cespare/vim-toml',
        ft = 'toml',
    },
    {
        'rust-lang/rust.vim',
        ft = 'rust',
    },
    {
        'Saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = {
            'jose-elias-alvarez/null-ls.nvim',
            'nvim-lua/plenary.nvim',
        },
        opts = {
            null_ls = {
                enabled = true,
                name = "crates.nvim",
            }
        },
        config = function(plugin, opts)
            require'crates'.setup(opts)
        end,
    },
    {
        'LnL7/vim-nix',
        ft = 'nix',
    },
    {
        'NoahTheDuke/vim-just',
        ft = {'just', 'Justfile'},
    },
    {
        'bazelbuild/vim-ft-bzl',
        ft = 'bzl',
    },
    {
        'barreiroleo/ltex_extra.nvim',
    },
    {
        'lervag/vimtex',
        ft = 'tex',
        config = function(plugin)
            vim.g.tex_flavor = 'latex'
        end,
    },
    {
        'ziglang/zig.vim',
        ft = 'zig',
    },
    {
        'jceb/vim-orgmode',
        ft = 'org',
    },
    {
        'bakpakin/fennel.vim',
        ft = 'fnl',
    },
    {
        'ahf/cocci-syntax',
        ft = 'cocci',
    },
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
    },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
    },
    {
        'numToStr/Comment.nvim',
        event = "BufRead",
        config = function(plugin, opts)
            require('Comment').setup(opts)
        end,
    },
    {
        'kylechui/nvim-surround',
        event = "VeryLazy",
        opts = {
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
        },
    },
    {
        'cbochs/portal.nvim',
        keys = {
            { '<leader>o', function() require'portal'.jump_backward() end, desc = 'portal backward'},
            { '<leader>i', function() require'portal'.jump_forward() end, desc = 'portal forward'},
        },
        config = function(plugin, opts)
            require 'portal'.setup(opts)
        end,
    },
    {
        'ggandor/leap.nvim',
        event = "VeryLazy",
        dependencies = {'tpope/vim-repeat'},
        config = function()
            require'leap'.add_default_mappings()
        end,
    },
    {
        "folke/zen-mode.nvim",
        dependencies = {'folke/twilight.nvim'},
        opts = {
            window = {
                options = {
                    number = false,
                },
            },
            plugins = {
                gitsigns = { enabled = true },
            },
        },
        keys = {
            {'<leader>tz', function() require'zen-mode'.toggle() end, desc = 'zen-mode'},
        },
        config = function(plugin, opts)
            require("zen-mode").setup(opts)
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
        },
        cmd = 'Telescope',
        opts = function()
            return {
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
        end,
        config = function(plugin, opts)
            local telescope = require 'telescope'
            telescope.setup(opts)
            -- FIXME: Fix lazy ui-select
            telescope.load_extension('ui-select')
            telescope.load_extension('fzy_native')
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = { 'InsertEnter' },
        opts = {
            fast_wrap = {},
        },
    },
    {
        'gbprod/yanky.nvim',
        opts = {},
        keys = {
            { 'p', '<Plug>(YankyPutAfter)', mode = {'n', 'x'}},
            { 'P', '<Plug>(YankyPutBefore)', mode = {'n', 'x'}},
            { 'gp', '<Plug>(YankyGPutAfter)', mode = {'n', 'x'}},
            { 'gP', '<Plug>(YankyGPutBefore)', mode = {'n', 'x'}},
            { '<c-n>', '<Plug>(YankyCycleForward)'},
            { '<c-p>', '<Plug>(YankyCycleBackward)'},
            { '<m-p>', '<cmd>YankyRingHistory<cr>'},
        },
        opts = {},
    },
    {
        'lambdalisue/suda.vim',
        cmd = {'SudaRead', 'SudaWrite'},
    },
    {
        'editorconfig/editorconfig-vim',
        event = 'BufRead',
    },
    {
        'junegunn/vim-easy-align',
        keys = {
            {'ga', '<Plug>(EasyAlign)', mode = {'n', 'x'}}
        },
    },
    {
        'monaqa/dial.nvim',
        keys = {
            { '<c-a>', '<Plug>(dial-increment)', { noremap = true }, desc = 'dial increment' },
            { '<c-x>', '<Plug>(dial-decrement)', { noremap = true }, desc = 'dial decrement' },
            { '<c-a>', '<Plug>(dial-increment)', { noremap = true }, mode = {'v'}, desc = 'dial increment' },
            { '<c-x>', '<Plug>(dial-decrement)', { noremap = true }, mode = {'v'}, desc = 'dial decrement' },
            { 'g<c-a>', 'g<Plug>(dial-increment)', { noremap = true }, mode = {'v'}, desc = 'dial increment' },
            { 'g<c-x>', 'g<Plug>(dial-decrement)', { noremap = true }, mode = {'v'}, desc = 'dial decrement' },
        },
    },
    {
        'skywind3000/asyncrun.vim',
        dependencies = {
            { 'skywind3000/asynctasks.vim' }
        },
        cmd = {'AsyncRun'},
        config = function(plugin)
            vim.g.asyncrun_open = 8
        end,
    },
    {
        'kevinhwang91/rnvimr',
        cmd = {'RnvimrToggle'},
        config = function(plugin)
            vim.g.rnvimr_enable_picker = 1
        end,
        keys = {
            { '<M-o>', '<cmd>RnvimrToggle<cr>', mode = {'n', 't'}, desc = 'open file', noremap = true, silent = true }
        },
    },
    {
        't-troebst/perfanno.nvim',
        cmd = {
            'PerfAnnotate',
            'PerfAnnotateSelection',
            'PerfCacheLoad',
            'PerfCycleFormat',
            'PerfHottestCallersSelection',
            'PerfHottestSymbols',
            'PerfLoadFlameGraph',
            'PerfLuaProfileStart',
            'PerfPickEvent',
            'PerfAnnotateFunction',
            'PerfCacheDelete',
            'PerfCacheSave',
            'PerfHottestCallersFunction',
            'PerfHottestLines',
            'PerfLoadCallGraph',
            'PerfLoadFlat',
            'PerfLuaProfileStop',
            'PerfToggleAnnotations'
        },
        keys = {
            { '<leader>cplp', '<cmd>PerfLoadFlat<cr>', desc = "perf-data", noremap = true, silent = true },
            { '<leader>cplg', '<cmd>PerfLoadFlat<cr>', desc = "perf-data-call-graph", noremap = true, silent = true },
            { '<leader>cplf', '<cmd>PerfLoadFlat<cr>', desc = "flamegraph", noremap = true, silent = true },

            { '<leader>cpe', '<cmd>PerfPickEvent<cr>', desc = "pick-event", noremap = true, silent = true },

            { '<leader>cpa', '<cmd>PerfAnnotate<cr>', desc = "annotate", noremap = true, silent = true },
            { '<leader>cpf', '<cmd>PerfAnnotateFunction<cr>', desc = "annotate-function", noremap = true, silent = true },
            { '<leader>cp', '<cmd>PerfAnnotateSelection<cr>', mode = {'v'}, desc = "annotate", noremap = true, silent = true },

            { '<leader>cpt', '<cmd>PerfToggleAnnotations<cr>', desc = "toggle", noremap = true, silent = true },

            { '<leader>cph', '<cmd>PerfHottestLines<cr>', desc = "hottest-lines", noremap = true, silent = true },
            { '<leader>cps', '<cmd>PerfHottestSymbols<cr>', desc = "hottest-symbols", noremap = true, silent = true },
            { '<leader>cpc', '<cmd>PerfHottestCallersFunction<cr>', desc = "hottest-callers-fn", noremap = true, silent = true },
            { '<leader>cpc', '<cmd>PerfHottestCallersSelection<cr>', mode = {'v'}, desc = "hottest-callers-sel", noremap = true, silent = true },

        },
        opts = {
            
        },
        config = function(plugin, opts)
            local perfanno = require 'perfanno'
            local util = require 'perfanno.util'
            local config = require 'perfanno.config'

            local function generate_color_config(opts)
                local bgcolor = vim.fn.synIDattr(vim.fn.hlID('Normal'), 'bg', 'gui')
                local color_config = {
                    line_highlights = util.make_bg_highlights(bgcolor, '#CC3300', 10),
                    vt_highlight = util.make_fg_highlight('#CC3300'),
                }
                return vim.tbl_deep_extend('force', vim.deepcopy(opts), color_config)
            end

            perfanno.setup(generate_color_config(opts))
            -- Automatically update colors on colorscheme change
            local color_autocmd = vim.api.nvim_create_augroup("PerfannoColorUpdate", { clear = true })
            vim.api.nvim_create_autocmd({'ColorScheme'}, {
                callback = function(ev)
                    config.load(generate_color_config(opts))
                end,
            })
        end,
    },
    {
        'junegunn/fzf.vim',
        dependencies = {'junegunn/fzf'},
        cmd = {
            'RG',
            'Files',
            'GFiles',
            'Buffers',
            'Colors',
            'Ag',
            'Rg',
            'Lines',
            'BLines',
            'Tags',
            'BTags',
            'Marks',
            'Windows',
            'Locate',
            'History',
            'Snippets',
            'Commits',
            'BCommits',
            'Commands',
            'Maps',
            'Helptags',
            'Filetypes',
        },
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
}

