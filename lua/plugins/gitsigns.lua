return {{
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    opts = {
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            -- Actions
            map('n', '<leader>ghs', gs.stage_hunk, {desc='stage hunk'})
            map('n', '<leader>ghr', gs.reset_hunk, {desc='reset hunk'})
            map('v', '<leader>ghs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc='stage hunk'})
            map('v', '<leader>ghr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc='reset hunk'})
            map('n', '<leader>ghS', gs.stage_buffer, {desc='stage buffer'})
            map('n', '<leader>ghu', gs.undo_stage_hunk, {desc='undo stage hunk'})
            map('n', '<leader>ghR', gs.reset_buffer, {desc='reset buffer'})
            map('n', '<leader>ghp', gs.preview_hunk, {desc='preview hunk'})
            map('n', '<leader>ghb', function() gs.blame_line{full=true} end, {desc='blame line'})
            map('n', '<leader>tb', gs.toggle_current_line_blame, {desc='line blame'})
            map('n', '<leader>ghd', gs.diffthis, {desc='diff this'})
            map('n', '<leader>ghD', function() gs.diffthis('~') end, {desc='diff this'})
            map('n', '<leader>ghd', gs.toggle_deleted, {desc='toggle deleted'})

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
    }
}}
