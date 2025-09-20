return {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
        completion = {
            menu = {
                auto_show = false,
            },
            documentation = {
                auto_show = true
            },
            ghost_text = {
                enabled = true,
            },
        },
        signature = { enabled = true },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust" }
    }
}
