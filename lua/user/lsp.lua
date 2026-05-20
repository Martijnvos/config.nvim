vim.api.nvim_create_augroup("LSP", { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = "LSP",
    desc = "Register keybindings",
    callback = function(args)
        local bufopts = { buffer = args.buf }
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        vim.keymap.set("n", "grd", vim.lsp.buf.definition, bufopts)

        if client:supports_method("textDocument/inlayHint") then
            vim.keymap.set("n", "<leader>ih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
            end, bufopts)
        end

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
