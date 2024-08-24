return {{
    'echasnovski/mini.diff',
    module = false,
    event = 'BufReadPre',
    opts = {
        view = {
            style = 'sign',
        },
        mappings = {
            goto_first = '',
            goto_last = '',
            goto_next = ']c',
            goto_prev = '[c',
        },
    },
    keys = {
        { "<leader>tg", function() require'mini.diff'.toggle_overlay() end, { silent = true }, desc = 'mini.diff overlay' },
    },
}}
