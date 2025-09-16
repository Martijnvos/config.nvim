--
-- vim.lsp.enable is called by mason-lspconfig.nvim, which installs all language servers

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Add additional capabilities supported by nvim-cmp
if package.loaded["cmp_nvim_lsp"] then
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

vim.lsp.config('*', {
    capabilities = capabilities,
})

vim.api.nvim_create_augroup("LSP", { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = "LSP",
    desc = "Register keybindings",
    callback = function(args)
        local bufopts = { buffer = args.buf }

        -- Actions
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, bufopts)
        vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, bufopts)

        if vim.lsp.inlay_hint then
            vim.keymap.set("n", "<leader>ih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
            end, bufopts)
        end

        -- Dialogs
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "<c-s>", vim.lsp.buf.signature_help, bufopts)

        -- Options
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

        -- Autocommands
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = "LSP",
            desc = "Auto-formatting on save",
            callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = args.data.client_id, timeout_ms = 1000 })
            end
        })
    end
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold" }, {
    group = "LSP",
    desc = "Auto-trigger CodeLens",
    callback = function()
        if vim.lsp.codelens then
            vim.lsp.codelens.refresh({ bufnr = 0 })
        end
    end,
})

-- Vim Diagnostics
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = 0 })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = 0 })
vim.keymap.set("n", "<leader>dll", vim.diagnostic.setloclist, { buffer = 0 })

vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float)
