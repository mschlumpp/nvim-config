local lspconfig = require 'lspconfig'
local saga = require 'lspsaga'
local completion = require 'completion'

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 4,
    },
    signs = true,
    update_in_insert = true,
    underline = true
  }
)

local servers = {
    clangd = {
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true
        },
        cmd = { "clangd", "--background-index", "--suggest-missing-includes", "--cross-file-rename", "--clang-tidy" }
    },
    gopls = { },
    jsonls = {
        cmd = {"json-languageserver"}
    },
    tsserver = {  },
    zls = { },
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

        local opts = {noremap = true, silent = true}
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', 'gh', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
        buf_set_keymap('i', '<c-k>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
        buf_set_keymap('n', '<M-CR>', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
        buf_set_keymap('v', '<M-CR>', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
        buf_set_keymap('n', ']g', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<cr>', opts)
        buf_set_keymap('n', '[g', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<cr>', opts)

        buf_set_keymap('n', '<leader>e', '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '<leader>E', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)

        if client.resolved_capabilities.document_formatting then
            buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
        end

        if client.resolved_capabilities.document_highlight then
            vim.api.nvim_exec([[
                augroup lsp_aucmds
                au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                au CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]], false)
        end

        completion.on_attach(client, bufnr)

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

saga.init_lsp_saga { }

