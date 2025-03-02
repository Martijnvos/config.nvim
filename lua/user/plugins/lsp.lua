return {
    {
        "neovim/nvim-lspconfig",  -- Collection of configurations for built-in LSP client
        dependencies = {
          "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
          "williamboman/mason-lspconfig.nvim", -- Lspconfig compatibility for Mason
          "Hoffs/omnisharp-extended-lsp.nvim", -- C# extended LSP functionality

          "editorconfig/editorconfig-vim",
        },
        config = function()
            local base_capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            local base_on_attach = function(client,bufnr)
                local bufopts = { buffer = bufnr }

                -- Actions
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, bufopts)

                -- Dialogs
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "<c-s>", vim.lsp.buf.signature_help, bufopts)

                -- Options
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, bufopts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
            end

            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "html",
                    "cssls",
                    "jsonls",
                    "marksman",
                    "ts_ls",
                    "omnisharp",
                },
                automatic_installation = true,
                handlers = {
                    function(server_name) -- default handler
                        require("lspconfig")[server_name].setup {
                            capabilities = base_capabilities,
                            on_attach = base_on_attach
                        }
                    end,
                    ["omnisharp"] = function()
                        require("lspconfig").omnisharp.setup {
                            capabilities = base_capabilities,
                            settings = {
                                RoslynExtensionsOptions = {
                                    EnableAnalyzersSupport = true,
                                    EnableImportCompletion = true,
                                },
                            },
                            on_attach = function(client, bufnr)
                                base_on_attach(client, bufnr)

                                local bufopts = { buffer = bufnr }
                                vim.keymap.set("n", "gd", require('omnisharp_extended').lsp_definition, bufopts)
                                vim.keymap.set("n", "gD", require('omnisharp_extended').lsp_type_definition, bufopts)
                                vim.keymap.set("n", "gi", require('omnisharp_extended').lsp_implementation, bufopts)
                                vim.keymap.set("n", "gr", require('omnisharp_extended').lsp_references, bufopts)
                            end
                        }
                    end,
                }
            })
        end
    }
}
