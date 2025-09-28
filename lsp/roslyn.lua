-- This is coming from a custom mason registry because of https://github.com/mason-org/mason-registry/pull/6330
-- source: https://github.com/Crashdummyy/roslynLanguageServer?tab=readme-ov-file
-- which monitors https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/, as described in https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#roslyn_ls
return {
    name = "roslyn",
    settings = {
        ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
        },
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
        }
    },
    on_attach = function()
        -- Basic .csproj formatting
        if not vim.g.roslyn_csproj_setup then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("RoslynProjectCsproj", { clear = true }),
                pattern = "*.csproj",
                callback = function(args)
                    local roslyn_clients = vim.lsp.get_clients({ name = "roslyn" })
                    if #roslyn_clients > 0 then
                        vim.api.nvim_buf_call(args.buf, function()
                            vim.cmd("normal! gg=G")
                        end)
                    end
                end,
            })
            vim.g.roslyn_csproj_setup = true
        end
    end
}
