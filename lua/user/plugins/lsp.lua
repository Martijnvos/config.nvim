return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "ts_ls", "cssls", "html", "jsonls", "marksman" },
        },
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {
                    registries = {
                        "github:mason-org/mason-registry",
                        "github:crashdummyy/mason-registry"
                    }
                }
            },
            "neovim/nvim-lspconfig",
        },
    },
    {
        -- Using the Mason config as described in the README
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {},
    },
    "hrsh7th/cmp-nvim-lsp",
    "editorconfig/editorconfig-vim",
}
