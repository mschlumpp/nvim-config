require'plenary.reload'.reload_module('lualine', true)
local navic = require 'nvim-navic'
require'lualine'.setup {
    extensions = {
        'quickfix',
        'nvim-tree',
        'toggleterm',
        'fugitive',
    },
    options = {
        theme = 'auto',
        icons_enabled = true,
    },
    sections = { 
        lualine_b = { 'branch', 'diff' } ,
        lualine_c = { 
            'filename', 
            {
                navic.get_location,
                cond = navic.is_available
            },
            { 
                'diagnostics', 
                sources = {'nvim_diagnostic'}
            },
        },
        lualine_x = { 
            'encoding', 
            'fileformat', 
            function () 
                -- Use bo.filetype directly because the lualine filetype
                -- handles a unloaded web-devicons package very poorly (it
                -- searches for the package using `require` *every* redraw,
                -- even when the icons are disabled. While require keeps a list
                -- of loaded packages, it does not optimize for "cache-misses")
                return vim.bo.filetype or ''
            end,
        },
    },
}
