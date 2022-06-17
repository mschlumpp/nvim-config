local npairs = require 'nvim-autopairs'
local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'vsnip' },
        { name = 'buffer', keyword_length = 5 },
        { name = 'path' },
    },
    formatting = {
        format = lspkind.cmp_format {},
    },
    experimental = {
        ghost_text = true,
    },
}


cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local vsnip_next = "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'"
vim.api.nvim_set_keymap('i', '<Tab>', vsnip_next, { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', vsnip_next, { expr = true })

local vsnip_prev = "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'"
vim.api.nvim_set_keymap('i', '<S-Tab>', vsnip_prev, { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', vsnip_prev, { expr = true })

local vsnip_expand = "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'"
vim.api.nvim_set_keymap('i', '<C-j>', vsnip_expand, { expr = true })
vim.api.nvim_set_keymap('s', '<C-j>', vsnip_expand, { expr = true })

local vsnip_expand_jump = "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'"
vim.api.nvim_set_keymap('i', '<C-l>', vsnip_expand_jump, { expr = true })
vim.api.nvim_set_keymap('s', '<C-l>', vsnip_expand_jump, { expr = true })
