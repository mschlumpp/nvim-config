local lspconfig = require 'lspconfig'
local lspkind = require 'lspkind'
local null_ls = require 'null-ls'
local navic = require 'nvim-navic'

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

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = 'single',
    }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = 'single',
    }
)

local pid = vim.fn.getpid()

local servers = {
    clangd = require 'clangd_extensions'.prepare {
        server = {
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                semanticHighlighting = true
            },
            flags = {
                allow_incremental_sync = true,
                debounce_text_changes = 1000,
            },
            cmd = { "clangd", "--background-index", "--suggest-missing-includes", "--cross-file-rename", "--clang-tidy" },
        },
        extensions = {
            symbol_info = {
                border = 'single',
            },
        },
    },
    gopls = { },
    pyright = { },
    omnisharp = {
        cmd = {"omnisharp", "--languageserver", "--hostPid", tostring(pid)}
    },
    jsonls = { 
        cmd = {"vscode-json-languageserver"}
    },
    tsserver = { },
    ltex = {
        settings = {
            ltex = {
                language = "en-US",
                checkFrequency = "save",
            },
        },
        flags = {
            debounce_text_changes = 9000,
        },
        after = function (client, bufnr)
            require("ltex_extra").setup {
                load_langs = { "en-US", "de-DE" },
                init_check = true,
            }
        end,
    },
    zls = { },
    html = {
        cmd = {"vscode-html-languageserver"}
    },
    rust_analyzer = {
        cmd = {"rust-analyzer"},
        flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 4000,
        },
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importMergeBehaviour = "module",
                },
                checkOnSave = {
                    command = "clippy",
                },
                completion = {
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
        buf_set_keymap('n', '<leader>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
        buf_set_keymap('n', '<leader>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('i', '<c-q>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>cn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('v', '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next({ float = true, popup_opts = { border = "single"}})<cr>', opts)
        buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev({ float = true, popup_opts = { border = "single"}})<cr>', opts)

        buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", { border = "single"}})<CR>', opts)
        buf_set_keymap('n', '<leader>E', '<cmd>lua vim.diagnostic.setqflist()<cr>', opts)

        if client.server_capabilities.documentFormattingProvider then
            buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<cr>', opts)
            buf_set_keymap('v', '<leader>=', '<cmd>lua vim.lsp.buf.format()<cr>', opts)
        end

        vim.api.nvim_exec([[
            augroup p_lsp_aucmds
            au! * <buffer>
        ]], false)
        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_exec([[
                au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                au CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            ]], false)
        end
        vim.api.nvim_exec([[
            augroup END
        ]], false)

        buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')
        buf_set_option('tagfunc', 'v:lua.vim.lsp.tagfunc')

        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end

        if config.after then config.after(client, bufnr) end
        if config.chain then config.chain(client, bufnr) end
    end
end

local snippet_capabilities = {
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = true,
                resolveSupport = {
                    properties = {
                        'documentation',
                        'detail',
                        'additionalTextEdits',
                    }
                }
            }
        }
    }
}

for server, config in pairs(servers) do
    -- remap any existing on_attach to chain hook
    config.chain = config.on_attach

    config.on_attach = make_on_attach(config)
    config.capabilities = vim.tbl_deep_extend('force', 
        vim.lsp.protocol.make_client_capabilities(), 
        require'cmp_nvim_lsp'.default_capabilities(),
        snippet_capabilities
    )

    lspconfig[server].setup(config)
end

require "fidget".setup {
    text = {
        spinner = "dots",
    }
}

lspkind.init({})

null_ls.setup({
    on_attach = make_on_attach({}),
    sources = {
        null_ls.builtins.code_actions.gitsigns,
    },
})
