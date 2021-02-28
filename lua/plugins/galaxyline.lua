local gl = require 'galaxyline'
local gls = gl.section

local colors = {
    bg = '#202328',
    section_bg = '#414752',
    fg = '#bbc2cf',
    yellow = '#fabd2f',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67',
}

local function file_readonly()
    if vim.bo.filetype == 'help' then return '' end
    if vim.bo.readonly then return '  ' end
    return ''
end

local function get_file_name()
    local file = vim.fn.expand('%:t')
    if vim.fn.empty(file) == 1 then return '' end
    if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
    if vim.bo.modifiable then
        if vim.bo.modified then return file .. '  ' end
    end
    return file
end

gls.left = {}
table.insert(gls.left, {
    ViMode = {
        provider = function() 
            local mode = {
                n =      { colors.green, "NORMAL" },
                i =      { colors.blue, "INSERT" },
                v =      { colors.magenta, "VISUAL" },
                [''] = { colors.magenta, "V-BLOCK" },
                V =      { colors.magenta, "V-LINE" },
                c =      { colors.green, "COMMAND"},
                no =     { colors.green, "(NORMAL)" },
                s =      { colors.orange, "SELECT" },
                S =      { colors.orange, "S-LINE" },
                [''] = { colors.orange, "S-BLOCK" },
                ic =     { colors.yellow, "COMPLETE" },
                R =      { colors.violet, "REPLACE" },
                Rv =     { colors.violet, "REPLACE" },
                cv =     { colors.red, "" },
                ce =     { colors.red, "" }, 
                r =      { colors.cyan, "" },
                rm =     { colors.cyan, "" }, 
                ['r?'] = { colors.cyan, "" },
                ['!']  = { colors.red, "" },
                t =      { colors.red, "TERM" },
            }

            local m = mode[vim.fn.mode()]
            if m ~= nil then
                vim.api.nvim_command('hi GalaxyViMode guibg=' .. m[1])
                return '  ' .. m[2] .. ' '
            else
                return ' ' .. vim.fn.mode() .. ' '
            end
        end,
        highlight = {colors.bg, colors.bg, 'bold'},
        separator_highlight = { colors.bg, colors.bg },
        separator = ' ',
    }
})

table.insert(gls.left, {
    GitBranch = {
        provider = 'GitBranch',

        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = { colors.fg, colors.section_bg },

        icon = ' ',
        separator = ' ',
        separator_highlight = { colors.section_bg, colors.bg },
    }
})

table.insert(gls.left, {
    FileName = {
        provider = function ()
            return ' ' .. get_file_name() .. ' '
        end,
        condition = function ()
            return not (vim.fn.empty(vim.fn.expand("%:t")) == 1)
        end,
        highlight = { colors.fg, colors.section_bg },

        separator_highlight = { colors.section_bg, colors.bg },
        separator = ' ',
    }
})

table.insert(gls.left, {
    DiffAdd = {
        provider = 'DiffAdd',
        icon = '+',
        highlight = { colors.green, colors.bg },
    }
})

table.insert(gls.left, {
    DiffModified = {
        provider = 'DiffModified',
        icon = '~',
        highlight = { colors.orange, colors.bg },
    }
})

table.insert(gls.left, {
    DiffModified = {
        provider = 'DiffRemove',
        icon = '-',
        highlight = { colors.orange, colors.bg },
    }
})

gls.right = {}
table.insert(gls.right, {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = ' ',
        highlight = {colors.red,colors.section_bg}
    }
})

table.insert(gls.right, {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = ' ',
        highlight = {colors.orange,colors.section_bg}
    }
})

table.insert(gls.right, {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = ' ',
        highlight = {colors.section_bg,colors.bg}
    }
})

table.insert(gls.right, {
    FileFormat = {
        provider = function() return vim.bo.filetype end,
        highlight = { colors.fg,colors.section_bg },
        separator = ' ',
        separator_highlight = { colors.section_bg, colors.bg },
    }
})

table.insert(gls.right, {
    LineInfo = {
        provider = 'LineColumn',
        highlight = { colors.fg, colors.section_bg },
        separator = ' ',
        separator_highlight = { colors.bg, colors.section_bg },
    },
})

table.insert(gls.right, {
    LinePercent = {
        provider = 'LinePercent',
        highlight = { colors.fg, colors.section_bg },
        separator = ' ',
        separator_highlight = { colors.bg, colors.section_bg },
    },
})

gls.short_line_left = {}
table.insert(gls.short_line_left, {
    BufferIcon = {
        provider= 'FileName',
        highlight = { colors.fg, colors.section_bg },
        separator = ' ',
        separator_highlight = { colors.section_bg, colors.bg },
    }
})

gls.short_line_right = {}
table.insert(gls.short_line_right, {
    BufferType = {
        provider = function() return vim.bo.filetype end,
        highlight = { colors.fg, colors.section_bg },
        separator = ' ',
        separator_highlight = { colors.section_bg, colors.bg },
    }
})

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
