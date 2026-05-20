require("mason").setup {
    registries = {
        "github:mason-org/mason-registry",
        "github:crashdummyy/mason-registry",
    },
    ensure_installed = { "typescript-language-server", "css-lsp", "html-lsp", "json-lsp", "marksman" },
}

vim.lsp.enable({ "ts_ls", "cssls", "html", "jsonls", "marksman", "roslyn" })
