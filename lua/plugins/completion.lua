local commands = {
    { 'nix',   'nix run .#build-plugin', nil },
    { 'cargo', 'cargo build --release',  nil },
}

-- Use an released version with binaries if no build tools are available
local version = '*' ---@type string?
local build_cmd ---@type string?

for _, cmd in ipairs(commands) do
    if vim.fn.executable(cmd[1]) == 1 then
        build_cmd = cmd[2]
        version = cmd[3]
        break
    end
end

return {
    {
        "L3MON4D3/LuaSnip",
        version = 'v2.*',
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function(_, opts)
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        'saghen/blink.cmp',
        event = "VeryLazy",
        version = version,
        build = build_cmd,
        dependencies = { 'L3MON4D3/LuaSnip' },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
            },
            snippets = { preset = 'luasnip' },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            signature = {
                enabled = true,
                window = {
                    show_documentation = false,
                },
            },
        },
        opts_extend = { 'sources.default' },
    }
}
