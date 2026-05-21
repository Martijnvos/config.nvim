vim.api.nvim_create_augroup("LSP", { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = "LSP",
    desc = "Register keybindings",
    callback = function(args)
        local bufopts = { buffer = args.buf }
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local builtin = require "telescope.builtin"

        vim.keymap.set("n", "grd", builtin.lsp_definitions, bufopts)
        vim.keymap.set("n", "grr", builtin.lsp_references, bufopts)
        vim.keymap.set("n", "gri", builtin.lsp_implementations, bufopts)
        vim.keymap.set("n", "grt", builtin.lsp_type_definitions, bufopts)
        vim.keymap.set("n", "gO", builtin.lsp_document_symbols, bufopts)

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
