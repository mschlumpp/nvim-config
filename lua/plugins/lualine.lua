require'plenary.reload'.reload_module('lualine', true)
require'lualine'.setup {
    extensions = {'quickfix', 'nvim-tree'},
    options = {
        theme = 'material',
        icons_enabled = false,
    },
    sections = { 
        lualine_b = { 'branch', 'diff' } ,
        lualine_c = { 
            'filename', 
            'b:lsp_current_function', 
            { 
                'diagnostics', 
                sources = {'nvim_lsp'}
            },
        },
        lualine_x = { 
            require'lsp-status'.status_progress, 
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
