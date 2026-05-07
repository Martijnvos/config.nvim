require("mason").setup {
    registries = {
        "github:mason-org/mason-registry",
        "github:crashdummyy/mason-registry",
    },
}

require("mason-lspconfig").setup {
    ensure_installed = { "ts_ls", "cssls", "html", "jsonls", "marksman" },
}
