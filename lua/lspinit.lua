local lsp_status = require 'lsp-status'
--lsp_status.register_progress()

local completion = require 'completion'
local lspconfig = require 'lspconfig'

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true
  }
)

local servers = {
    jsonls = { },
    clangd = {
        handlers = lsp_status.extensions.clangd.setup(),
        init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true
        },
    },
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                serverPath = "rust-analyzer",
                assist = {
                    importMergeBehaviour = "last",
                },
                checkOnSave = {
                    command = "clippy",
                },
                inlayHints = {
                    --refreshOnInsertMode = true,
                },
                diagnostics = {
                    enableExperimental = true,
                    disabled = { "macro-error" }
                },
                completion = {
                    enableExperimental = true,
                    addCallArgumentSnippets = true,
                    addCallParenthesis = true,
                    ["postfix.enable"] = true,
                },
                procMacro = {
                    enable = true,
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
            }
        }
    }
}

local function make_on_attach(config) 
    return function(client)
        if config.before then config.before(client) end

        completion.on_attach()
        lsp_status.on_attach(client)
        local opts = {noremap = true, silent = true}
        vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>m', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)

        -- TODO: Check if convenient
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>E', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)

        if client.resolved_capabilities.document_formatting then
            vim.api.nvim_buf_set_keymap(0, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>',
            opts)
        end

        if client.resolved_capabilities.document_highlight then
            vim.api.nvim_command('augroup lsp_aucmds')
            vim.api.nvim_command('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
            vim.api.nvim_command('au CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()')
            vim.api.nvim_command('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
            vim.api.nvim_command('augroup END')
        end

        if config.after then config.after(client) end
    end
end

local snippet_capabilities = {
  textDocument = {completion = {completionItem = {snippetSupport = true}}}
}

for server, config in pairs(servers) do
    config.on_attach = make_on_attach(config)
    config.capabilities = vim.tbl_deep_extend('force', config.capabilities or {}, --[[lsp_status.capabilities,]] snippet_capabilities)

    lspconfig[server].setup(config)
end

