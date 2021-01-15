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
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true
        },
        cmd = { "clangd", "--background-index", "--suggest-missing-includes", "--cross-file-rename", "--clang-tidy" }
    },
    gopls = { },
    jsonls = { },
    tsserver = {  },
    rust_analyzer = {
        cmd = {"rust-analyzer"},
        settings = {
            ["rust-analyzer"] = {
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
    return function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        if config.before then config.before(client) end

        completion.on_attach()
        local opts = {noremap = true, silent = true}
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<M-CR>', '<cmd>lua require"telescope.builtin".lsp_code_actions(require("telescope.themes").get_dropdown({ winblend = 5 }))<CR>', opts)
        buf_set_keymap('v', '<leader>m', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
        buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
        buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)

        buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '<leader>E', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)

        if client.resolved_capabilities.document_formatting then
            buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
        end

        if client.resolved_capabilities.document_highlight then
            lspconfig.util.nvim_multiline_command [[
                augroup lsp_aucmds
                au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                au CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]]
        end

        if config.after then config.after(client) end
    end
end

local snippet_capabilities = {
  textDocument = {completion = {completionItem = {snippetSupport = true}}}
}

for server, config in pairs(servers) do
    config.on_attach = make_on_attach(config)
    config.capabilities = vim.tbl_deep_extend('force', 
        vim.lsp.protocol.make_client_capabilities(), 
        snippet_capabilities
    )

    lspconfig[server].setup(config)
end

