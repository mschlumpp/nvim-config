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
        'glepnir/galaxyline.nvim',
        config = [[require('plugins.galaxyline')]],
    }
    use 'chriskempson/base16-vim'
    use 'rainglow/vim'
    use {
        'sonph/onehalf',
        rtp = 'vim',
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
            vim.cmd('colorscheme jellybeans')
        end
    }
    use {
        'dstein64/nvim-scrollview'
    }
    use {
        'kevinhwang91/nvim-bqf'
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = [[require('plugins.gitsigns')]],
    }
    use { 
        'akinsho/nvim-toggleterm.lua',
        keys = {[[<c-\>]]},
        config = [[require('plugins.toggleterm')]],
    }
    use {
        'liuchengxu/vim-which-key',
        config = [[require('plugins.which_key')]],
    }
    use {
        'mhinz/vim-sayonara',
        cmd = {'Sayonara'},
    }
    use {
        'hrsh7th/nvim-compe',
        config = [[require('plugins.completion')]],
        requires = {'hrsh7th/vim-vsnip', 'hrsh7th/vim-vsnip-integ'},
        config = [[require('plugins.completion')]],
    }
    use {
        'neovim/nvim-lspconfig',
        requires = {'onsails/lspkind-nvim', 'gfanto/fzf-lsp.nvim', 'glepnir/lspsaga.nvim'},
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
        'LnL7/vim-nix',
        ft = 'nix',
    }
    use {
        'bazelbuild/vim-ft-bzl',
        ft = 'bzl',
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
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
    }
    use {
        'sjbach/lusty',
        cmd = {'LustyFilesystemExplorerFromHere'},
        opt = true,
        config = [[
            vim.g.LustyExplorerDefaultMappings = 0
        ]],
    }
    use {
        'tpope/vim-fugitive',
        cmd = 'Git',
    }
    use {
        'tpope/vim-commentary',
    }
    use {
        'tpope/vim-surround',
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
        'cohama/lexima.vim',
        config = [[
            vim.g.lexima_no_default_rules = true
            vim.fn['lexima#set_default_rules']()
        ]]
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim', 
            'nvim-lua/popup.nvim',
        },
        module = 'telescope',
        cmd = 'Telescope',
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    winblend = 5
                }
            }
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
        'chrisbra/SudoEdit.vim',
        cmd = {'SudoRead', 'SudoWrite'},
    }
    use {
        'editorconfig/editorconfig-vim'
    }
    use {
        'mcchrish/nnn.vim'
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
end)
