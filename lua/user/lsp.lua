--
-- vim.lsp.enable is called by mason-lspconfig.nvim, which installs all language servers

vim.api.nvim_create_augroup("LSP", { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = "LSP",
    desc = "Register keybindings",
    callback = function(args)
        local bufopts = { buffer = args.buf }
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Actions
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, bufopts)
        vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, bufopts)

        if client:supports_method("textDocument/inlayHint") then
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

        -- Autocommands (per-buffer group to prevent duplicates on re-attach)
        local bufgroup = vim.api.nvim_create_augroup("LSP_buf_" .. args.buf, { clear = true })
        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = bufgroup,
                desc = "Auto-formatting on save",
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format()
                end
            })
        end

        if client:supports_method("textDocument/codeLens") then
            vim.lsp.codelens.enable(true, { bufnr = args.buf })
        end
    end
})
